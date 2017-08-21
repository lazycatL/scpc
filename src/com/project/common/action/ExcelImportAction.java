package com.project.common.action;

import com.opensymphony.xwork2.ActionSupport;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.ExcelExportUtil;
import com.project.util.JsonObjectUtil;
import com.project.util.RandomUtils;
import com.project.util.WebUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 资源导入，根据上传Excel读取数据插入到数据库
 */
public class ExcelImportAction extends ActionSupport {
	
	private SelectDataService selectDataService;
	private static final long serialVersionUID = 1L;

	public SelectDataService getSelectDataService() {
		return selectDataService;
	}

	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 获取各资源数据列表对应资源表字段名称及属性.
	 */
	public void excel(){

        POIFSFileSystem fs;
        HSSFWorkbook wb;
        HSSFSheet sheet;
        HSSFRow row;
        String filepath=Request.getParameter("filepath");//获取文件上传后的绝对路径
        String importtype=Request.getParameter("importtype");//导入方式01更新导入，02新增导入
        if(importtype==null || importtype.equals(""))
        {
            importtype="01";//如果没有指定刀肉方式则直接新增
        }
        String returnJson="SUCCESS";
        String sheetName="";
        String tableName="";
        String columns="";
        String columnContext="";
        String getColumnMsgSql = "SELECT table_name,resource_name,LOWER(column_name) column_name,column_cname,data_type,PROPERTY_TYPE,TYPESQL FROM resource_table t,resource_table_column c WHERE t.`TABLE_ID`=c.`TABLE_ID`  AND ISINPORT=1 ";
        boolean flag=false;
        String ssht="";
        String bomid="";
        String typesql="";
        try{

            InputStream is = new FileInputStream(filepath);
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
            sheet = wb.getSheetAt(0);
            row = sheet.getRow(0);

            sheetName=sheet.getSheetName();//获取SHEET名称根据名称查询出该表配置
            // 标题总列数
            int colNum = row.getPhysicalNumberOfCells();
            ArrayList sqlList = new ArrayList();

            if(!sheetName.equals(""))
            {
                getColumnMsgSql+=" AND t.resource_name='"+sheetName+"'  ORDER BY export_order";
            }
            List<ListOrderedMap> list = this.selectDataService.queryForList(getColumnMsgSql);
            List<ListOrderedMap> newList=new ArrayList();

            if(list.size()>0)//选择的文件，在配置中
            {
                tableName=list.get(0).get("table_name").toString();

                    for (int i = 0; i < colNum; i++) {
                        for(int j=0;j<list.size();j++)//循环
                        {
                            ListOrderedMap lom = list.get(j);
                            if(lom.get("PROPERTY_TYPE").toString().equals("10"))
                            {
                                typesql=lom.get("typesql").toString();
                            }
                            if( getCellFormatValue(row.getCell((short) i)).equals(lom.get("column_cname")))
                            {
                                columns+=lom.get("column_name")+",";
                                newList.add(lom);
                                if(tableName.toUpperCase().equals("SCGLXT_T_BOM") && lom.get("column_name").equals("cldx"))
                                {
                                    columns+="cltj,clje,clzl,";
                                }
                                break;
                            }
                    }
                }
                //如果导入的表是合同报价单，则自动增加所属合同
                if(tableName.toUpperCase().equals("SCGLXT_T_HT_BJD"))
                {
                    if(!columns.contains("ssht")) {
                        columns += "ssht,";
                        ssht=Request.getParameter("ssht");
                        if (ssht == null || ssht.equals("")) {
                            Response.write("没有所属合同信息无法导入!");
                        }
                        String sql="select * from scglxt_t_bom where ssdd=(select id from scglxt_t_dd where ssht='"+ssht+"')";
                        List bomcountList=selectDataService.queryForList(sql);
                        if(bomcountList.size()==0)
                        {
                            flag=true;
                        }
                    }
                }
                //如果导入的表是BOM下的工艺工序内容则自动补充所属BOM
                if(tableName.toUpperCase().equals("SCGLXT_T_GYGC"))
                {
                    if(!columns.contains("bomid")) {
                        columns = "bomid,serial,"+columns;
                        bomid=Request.getParameter("bomid");
                        if (bomid == null || bomid.equals("")) {
                            Response.write("没有所属BOM信息无法导入工艺工序!");
                        }
                        String sql="select * from SCGLXT_T_GYGC where bomid=(select id from SCGLXT_T_GYGC where bomid='"+bomid+"')";
                        List bomcountList=selectDataService.queryForList(sql);
                        if(bomcountList.size()==0)
                        {
                            flag=true;
                        }
                    }
                }
                columns=columns.substring(0,columns.length()-1);
                if(columns.length()>0) {
                    Map<Integer, String> excelContent = new HashMap<Integer, String>();
                    // 得到总行数
                    int rowNum = sheet.getLastRowNum();
                    // 正文内容应该从第二行开始,第一行为表头的标题
                    for (int i = 1; i <= rowNum; i++) {
                        row = sheet.getRow(i);
                        String udpateWhere="";
                        for(int j=0;j<newList.size();j++)
                        {
                            ListOrderedMap lom = newList.get(j);
                            if(lom.get("data_type").toString().equals("1"))//字符串类型
                            {
                                if((lom.get("PROPERTY_TYPE").toString().equals("2")))//翻译列
                                {
                                    String value=getCellFormatValue(row.getCell((short) j));
                                    if(value.equals("")){
                                        if(importtype.equals("01")) {
                                            columnContext += "'',";
                                        }else{
                                            columnContext+=lom.get("column_name")+"='',";
                                        }
                                    }else{
                                        if(importtype.equals("01")) {
                                            columnContext += "(SELECT t.id FROM (" + lom.get("TYPESQL").toString() + ") t WHERE t.name='" + getCellFormatValue(row.getCell((short) j)).trim() + "'),";

                                        }else {
                                            columnContext+=lom.get("column_name")+"="+"(SELECT t.id FROM (" + lom.get("TYPESQL").toString() + ") t WHERE t.name='" + getCellFormatValue(row.getCell((short) j)).trim() + "'),";

                                            if(j==0)//记录更新条件
                                            {
                                                udpateWhere=lom.get("column_name")+"="+"(SELECT t.id FROM (" + lom.get("TYPESQL").toString() + ") t WHERE t.name='" + getCellFormatValue(row.getCell((short) j)).trim() + "') ";
                                            }
                                        }
                                    }
                                }else{
                                    if(importtype.equals("01")) {
                                        columnContext += "'" + getCellFormatValue(row.getCell((short) j)).trim() + "',";
                                    }else{
                                        if(j==0)//记录更新条件
                                        {
                                            udpateWhere=lom.get("column_name")+"='"+ getCellFormatValue(row.getCell((short) j)).trim()+"'";
                                        }
                                        if(j==1)//记录更新条件
                                        {
                                            udpateWhere+=" and "+lom.get("column_name")+"='"+ getCellFormatValue(row.getCell((short) j)).trim()+"'";
                                        }
                                        columnContext+=lom.get("column_name")+"='" + getCellFormatValue(row.getCell((short) j)).trim() + "',";
                                    }
                                }

                                //如果当前循环的列是BOM表的中的材料大小，则根据材料大小,和所选材料计算出该材料的体积，质量，金额等信息
                                if(tableName.toUpperCase().equals("SCGLXT_T_BOM") && lom.get("column_name").equals("cldx"))
                                {
                                    String clmc=row.getCell(2).toString();//材料名称
                                    String clxz=row.getCell(4).toString();//材料形状
                                    String cldx=row.getCell(5).toString();//材料形状
                                    Double cltj=null;
                                    Double clje=null;
                                    Double clzl=null;
                                    if(cldx.length()>0)
                                    {
                                        String[] cldxArr=cldx.split("\\*");
                                        if(clxz.equals("长方体"))
                                        {
                                            if(cldx.contains("φ")) {
                                                cltj = Double.valueOf(Integer.valueOf(cldxArr[0]) * Integer.valueOf(cldxArr[1]) * Integer.valueOf(cldxArr[2]));
                                            }else{
                                                clxz="圆柱体";
                                                int d=Integer.valueOf(cldxArr[0].substring(1,cldxArr[0].length()));
                                                cltj=Double.valueOf(3.1415926*(d*(d/2))*Integer.valueOf(cldxArr[1]));
                                            }
                                        }else{
                                            int d=Integer.valueOf(cldxArr[0].substring(1,cldxArr[0].length()));
                                            cltj=Double.valueOf(3.1415926*(d*(d/2))*Integer.valueOf(cldxArr[1]));
                                        }
                                        cltj=Double.valueOf(cltj/1000);//换算成立方厘米
                                        String sql="select cldj,mi from scglxt_t_cl where clmc='"+clmc+"'";
                                        List<ListOrderedMap> clList = this.selectDataService.queryForList(sql);
                                        if(clList.size()>0)
                                        {
                                            ListOrderedMap clOrder=clList.get(0);
                                            clzl=cltj*Double.valueOf(clOrder.get("mi").toString());
                                            clje=clzl*Double.valueOf(clOrder.get("cldj").toString());
                                            if(importtype.equals("01")) {
                                                columnContext += cltj + "," + clje + "," + clzl + ",";
                                            }else{
                                                columnContext +="cltj="+ cltj + ",clje=" + clje + ",clzl='" + clzl + "',";
                                            }
                                        }else{
                                            if(importtype.equals("01")) {
                                                columnContext += "null,null,null,";
                                            }else{
                                                columnContext += "cltj=null,clje=null,clzl=null,";
                                            }
                                            System.out.println("第"+i+"行，材料名称不在字典中，无法计算体积金额。");
                                        }
                                    }else{
                                        if(importtype.equals("01")) {
                                            columnContext += "null,null,null,";
                                        }else{
                                            columnContext += "cltj=null,clje=null,clzl=null,";
                                        }
                                    }
                                }
                                //合同报价单的信息录入增加所属合同字段
                                if(tableName.toUpperCase().equals("SCGLXT_T_HT_BJD") && lom.get("column_name").equals("shr"))
                                {
                                    if(columns.contains("ssht")) {
                                        if(flag)
                                            columnContext += "'" +ssht + "',";
                                    }
                                }
                            }else if(lom.get("data_type").toString().equals("2")){
                                String value=getCellFormatValue(row.getCell((short) j)).trim();
                                if(value==null || value.equals(""))
                                {
                                    value="0";
                                }
                                if(importtype.equals("01")) {
                                    columnContext += value + ",";
                                }else{
                                    columnContext+=lom.get("column_name")+"=" + value + ",";
                                }
                            }else if(lom.get("data_type").toString().equals("3")){
                                if(importtype.equals("01")) {
                                    columnContext += "date_format('" + getCellFormatValue(row.getCell((short) j)).trim() + "','%Y-%m-%d %H:%i:%s'),";
                                }else{
                                    columnContext+=lom.get("column_name")+"=" + "date_format('" + getCellFormatValue(row.getCell((short) j)).trim() + "','%Y-%m-%d %H:%i:%s'),";
                                }
                            }
                        }

                        columnContext=columnContext.substring(0,columnContext.length()-1);
                        String id=WebUtils.getRandomId();
                        if(!typesql.equals(""))
                        {
                            id=selectDataService.getString("SELECT "+typesql+" from dual");
                            if(id.equals("") || id==null)
                            {
                                id=WebUtils.getRandomId();
                            }
                        }

                        String sql="";
                        if(importtype.equals("01")) {

                            //如果是工艺工序表则自动增加所属BOM和工序排序
                            if(tableName.toUpperCase().equals("SCGLXT_T_GYGC"))
                            {
                                if(columns.contains("bomid")) {
                                    if(flag)
                                        columnContext = "'" +bomid + "',"+i+","+columnContext;
                                }
                            }

                            sql = "insert into " + tableName + "(id," + columns + ") values('" + id + "'," + columnContext + ")";
                        }else{
                            sql="Update "+tableName+" set "+columnContext + " where "+udpateWhere;
                        }

                        System.out.println(sql);
                        try {
                            selectDataService.execute(sql);
                            if(tableName.toUpperCase().equals("SCGLXT_T_GYGC"))
                            {
                                updateBomGynrByGxbp(bomid);
                            }
                        }catch (Exception e)
                        {
                            System.out.println("插入数据出错："+sql);
                        }
                        columnContext="";

                        //如果当前表是BOM表则读取该行的工艺工序自动分割到工艺表
//                        if(tableName.toUpperCase().equals("SCGLXT_T_BOM"))
//                        {
//                            String gynr=row.getCell(6).toString();
//                            String[] gynrList=gynr.split("-");
//                            if(gynrList.length>0)
//                            {
//                                for(int ii=0;ii<gynrList.length;ii++)
//                                {
//                                    String gynrmc=gynrList[ii].toString().replace("（","(").split("\\(")[0];
//                                    String bzgs=gynrList[ii].toString().replace("）",")").split("\\(")[1].replace(")","");
//                                    String insertgySql="insert into scglxt_t_gygc(id,bomid,gynr,bzgs,serial) values('"+
//                                    WebUtils.getRandomId()+"','"+id+"',(SELECT t.id FROM (SELECT id,gymc NAME FROM scglxt_t_jggy) t  WHERE t.name = '"+gynrmc+"'),"+bzgs+","+ii+")";
//                                    //sqlList.add(insertgySql);
//                                    selectDataService.execute(insertgySql);
//                                }
//                            }
//                        }
                    }
                    //如果当前导入的是合同的报价单，如果该合同下的订单是唯一的并且没有相关BOM则初始化BOM数据
                    if(tableName.toUpperCase().equals("SCGLXT_T_HT_BJD"))
                    {
                        if(flag){
                            String insertBomSql="INSERT INTO scglxt_t_bom(id,ssdd,zddmc,ddtz,zddcz,jgsl) SELECT CONCAT( DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), LPAD((@i:=@i+1),5,'0') ) id,(SELECT id FROM scglxt_t_dd" +
                                    " WHERE ssht='"+ssht+"') ssdd,ljmc,th,cz,ABS(sl) FROM scglxt_t_ht_bjd,(SELECT @i:=0) t WHERE ssht='"+ssht+"'";
                            System.out.println("初始化合同下BOM:"+insertBomSql);
                            selectDataService.execute(insertBomSql);
                        }
                    }

                    returnJson="SUCCESS";
                }else{
                    returnJson="上传EXCEL没有匹配的列。";
                    System.out.println("上传EXCEL没有匹配的列!");
                }
            }else{
                returnJson="上传EXCEL没有在配置表中配置。";
                System.out.println("上传EXCEL没有在配置表中配置!");
            }
        }catch(Exception e)
        {
            e.printStackTrace();
            returnJson="导入出错！";
        }
		Response.write(returnJson);
	}
    /**
     * 根据HSSFCell类型设置数据
     * @param cell
     * @return
     */
    private String getCellFormatValue(HSSFCell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
                // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:{
                    cellvalue = String.valueOf(Math.round(cell.getNumericCellValue()));
                    if(cellvalue.equals(""))
                    {
                        cellvalue="";
                    }
                }
                case HSSFCell.CELL_TYPE_FORMULA: {
                    // 判断当前的cell是否为Date
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        // 如果是Date类型则，转化为Data格式

                        //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
                        //cellvalue = cell.getDateCellValue().toLocaleString();

                        //方法2：这样子的data格式是不带带时分秒的：2011-10-12
                        Date date = cell.getDateCellValue();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        cellvalue = sdf.format(date);

                    }
                    // 如果是纯数字
                    else {
                        // 取得当前Cell的数值
                        cellvalue = String.valueOf(Math.round(cell.getNumericCellValue()));
                    }
                    break;
                }
                // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
                // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;

    }

    public void updateBomGynrByGxbp(String bomid)
    {
        if ((bomid == null) || (bomid.equals(""))) {
            return;
        }
        List list = null;
        String gygcSql = "select t.id ,t2.gymc gynr ,t.edgs,t.bzgs,bom.clzt,bom.jgsl from scglxt_t_bom bom,scglxt_t_gygc  t ,scglxt_t_jggy t2  where t.`bomid`=bom.id AND t.gynr = t2.id  and bomid = '" +
                bomid + "'  order by serial ";
        String gynr = "";
        String sql = "";
        try
        {
            list = this.selectDataService.queryForList(gygcSql);
            if (list.size() > 0)
            {
                for (int i = 0; i < list.size(); i++)
                {
                    ListOrderedMap lom = (ListOrderedMap)list.get(i);
                    gynr = gynr + lom.get("gynr").toString() + "(" + lom.get("bzgs").toString() + ")-";
                }
                gynr = gynr.substring(0, gynr.length() - 1);
            }
            sql = "update  scglxt_t_bom set gxnr =  '" + gynr + "' where id = '" + bomid + "'";

            this.selectDataService.execute(sql);
            ListOrderedMap lom = (ListOrderedMap)list.get(0);
            if( lom.get("clzt")!=null)
            {
                if( lom.get("clzt").toString().equals("1"))
                {
                    sql = "update  scglxt_t_gygc set kjgjs =  '" +  lom.get("jgsl").toString() + "' where bomid = '" + bomid + "' and serial='0'";
                    this.selectDataService.execute(sql);
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


}
