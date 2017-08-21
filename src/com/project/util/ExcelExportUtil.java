package com.project.util;

/**
 * Created by lihong on 2016/7/23.
 */
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.DateUtil;
import org.apache.commons.logging.Log;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;

public class ExcelExportUtil extends HttpServlet {
    //访问网址：http://localhost:8080/scpc/servlet/ExcelExportServlet


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("octets/stream");
//      response.addHeader("Content-Disposition", "attachment;filename=test.xls");
        String excelName = "学生信息表";
        //转码防止乱码
        response.addHeader("Content-Disposition", "attachment;filename="+new String( excelName.getBytes("gb2312"), "ISO8859-1" )+".xls");
        String[] headers = new String[]{"编号","姓名","年龄","性别"};
        try {
            OutputStream out = response.getOutputStream();
            exportExcel(excelName,headers, getList(), out,"yyyy-MM-dd");
            out.close();
            System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    /**
     *
     * @Description: 模拟从数据库中查询出来的数据，一般是数据表中的几列
     * @Auther: lujinyong
     * @Date: 2013-8-22 下午2:53:58
     */
    public static List<Map<String,Object>> getList(){
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        for(int i = 0; i<100;i++){
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("number",1000+i);
            map.put("name", "张三"+i);
            int age = (int)(Math.random()*100);
            do{
                age = (int)(Math.random()*100);
            }while(age<10||age>15);
            map.put("age", age);
            map.put("sex", age%2==0?0:1);//获得随机性别
            list.add(map);
        }
        return list;
    }
    /**
     *
     * @Description: 生成excel并导出到客户端（本地）
     * @Auther: lujinyong
     * @Date: 2013-8-22 下午3:05:49
     */
    public static void exportExcel(String title,String[] headers,List mapList,OutputStream out,String pattern){
        //声明一个工作簿
        HSSFWorkbook workbook = new HSSFWorkbook();
        //生成一个表格
        HSSFSheet sheet = workbook.createSheet(title);
        //设置表格默认列宽度为15个字符
        sheet.setDefaultColumnWidth(15);
        //生成一个样式，用来设置标题样式
        HSSFCellStyle style = workbook.createCellStyle();
        //设置这些样式
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style.setFillForegroundColor(HSSFColor.WHITE.index);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        //生成一个字体
        HSSFFont font = workbook.createFont();
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        //把字体应用到当前的样式
        style.setFont(font);
        // 生成并设置另一个样式,用于设置内容样式
        HSSFCellStyle style2 = workbook.createCellStyle();
        style2.setFillForegroundColor(HSSFColor.WHITE.index);
        style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        // 生成另一个字体
        HSSFFont font2 = workbook.createFont();
        font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        // 把字体应用到当前的样式
        style2.setFont(font2);
        //产生表格标题行
        HSSFRow row = sheet.createRow(0);
        row.setHeightInPoints(22);
        for(int i = 0; i<headers.length;i++){
            HSSFCell cell = row.createCell(i);
            cell.setCellStyle(style);
            HSSFRichTextString text = new HSSFRichTextString(headers[i]);
            cell.setCellValue(text);
        }
        for (int i=0;i<mapList.size();i++) {
            Map<String,Object> map = (Map<String, Object>) mapList.get(i);
            row = sheet.createRow(i+1);
            row.setHeightInPoints(22);
            int j = 0;
            Object value = null;
            for(String key:map.keySet())
            {
                value=map.get(key);
                if(value==null)
                {
                    value="";
                }
                HSSFCell cell = row.createCell(j);
                cell.setCellStyle(style2);
                cell.setCellValue(String.valueOf(value));
                j++;
            }
        }


       // exportGygx("20160927195701562",workbook,sheet,style,style2);
        try {
            workbook.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     *  根据传入的work和bomid返回该Bomid下所有工艺工序的内容
     * @author lihong
     * @date 2016-12-29 09:59:31
     */
    public  static int exportGygx(String ii,SelectDataService selectDService,String bomid,HSSFWorkbook workbook,HSSFSheet sheet,HSSFCellStyle style2,HSSFCellStyle style3,int rowNum,String bmcl)
    {
        int newRowNum=0;
        String bomSql="SELECT bom.id,htbh khbh,dd.xmname ddmc,cl.clmc,dd.endtime jhdate,zddmc,bom.ddtz,bom.jgsl,bom.cldx FROM scglxt_t_bom bom," +
                " scglxt_t_ht ht,scglxt_t_dd dd,scglxt_t_cl cl WHERE ht.id=dd.ssht AND dd.id=bom.ssdd AND bom.zddcz=cl.id AND  bom.id ='"+bomid+"'";

        String blsql="SELECT '1' AS rownum,'备料' AS sbmc,CONCAT(bom.cldx,'      ',bom.bljs,'      ',cl.clmc ) gynr,NULL AS t,NULL AS edgs,NULL AS zgs,NULL AS jhwcsj,NULL AS sjwcsj, NULL AS czr," +
                "NULL AS jyr FROM scglxt_t_bom bom,scglxt_t_cl cl WHERE bom.zddcz=cl.id AND  bom.id ='"+bomid+"'" ;
        String gygxSql=" SELECT (@rownum:=@rownum+1) AS rownum,gy.gymc sbmc,gc.`ZYSX` gynr,null as t,edgs,gc.bzgs zgs,NULL AS jhwcsj,NULL AS sjwcsj," +
                "\"\" AS czr,\"\" AS jyr FROM scglxt_t_sblx sb LEFT JOIN scglxt_t_gygc gc ON sb.`id`=gc.`sbid` LEFT JOIN scglxt_t_jggy gy ON gc.`gynr` = gy.`id` where  bomid='"+bomid+"'  ORDER BY SERIAL";

        String[] headers = new String[]{"序号","所属设备","工序内容（工艺）","","额定工时(分钟/件)","总工时(分钟/件)","要求完成日期","实际完成日期","操作者","检验"};

        //设置行高,工艺卡默认行高14.25
        double df = 14.25;
        float h = Float.parseFloat(String.valueOf(df));//一倍行高
        float h_2 = Float.parseFloat(String.valueOf(df*2-1));//二倍行高

        List bomlist = selectDService.queryForList(bomSql);
        Map<String,Object> bomMap = (Map<String, Object>) bomlist.get(0);


        //合并第一行0-7单元格
        Region region = new Region(rowNum, (short) 0, rowNum, (short)7);
        sheet.addMergedRegion(region);
        //合并第一行8-9单元格
        Region region0 = new Region(rowNum, (short) 8, rowNum, (short)9);
        sheet.addMergedRegion(region0);
        //合并第二行0-2单元格(工艺过程卡内容）
        Region region1 = new Region(rowNum+1, (short) 0, rowNum+2, (short)2);
        sheet.addMergedRegion(region1);

        //合并第三行0-4单元格
        Region region2 = new Region(rowNum+2, (short) 0, rowNum+2, (short)2);
        sheet.addMergedRegion(region2);

        //合并第四行7-8单元格
        Region region7 = new Region(rowNum+3, (short) 2, rowNum+3, (short)3);
        sheet.addMergedRegion(region7);

        //合并第2行7-8单元格
        Region region9 = new Region(rowNum+1, (short) 8, rowNum+1, (short)9);
        sheet.addMergedRegion(region9);

        //合并第2行7-8单元格
        Region region8 = new Region(rowNum+2, (short) 8, rowNum+2, (short)9);
        sheet.addMergedRegion(region8);

        //生成一个样式，用来设置标题样式
        HSSFCellStyle style = workbook.createCellStyle();
        //设置这些样式
        style.setFillForegroundColor(HSSFColor.WHITE.index);
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);

        //生成第一行字体
        HSSFFont font = workbook.createFont();
        font.setColor(HSSFColor.BLACK.index);//设置字体颜色
        font.setFontHeightInPoints((short) 24);//设置第一行字体大小
        // 把字体应用到当前的样式
        style.setFont(font);

        //生成一个样式，设置字体距左显示
        HSSFCellStyle styleLeft = workbook.createCellStyle();
        //设置这些样式
        styleLeft.setFillForegroundColor(HSSFColor.WHITE.index);
        styleLeft.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        styleLeft.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        styleLeft.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        styleLeft.setBorderRight(HSSFCellStyle.BORDER_THIN);
        styleLeft.setBorderTop(HSSFCellStyle.BORDER_THIN);
        styleLeft.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        styleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        styleLeft.setWrapText(true);
        //生成第一行字体
        HSSFFont fontLeft = workbook.createFont();
        fontLeft.setColor(HSSFColor.BLACK.index);//设置字体颜色
        fontLeft.setFontHeightInPoints((short) 10);//设置第一行字体大小
        // 把字体应用到当前的样式
        styleLeft.setFont(fontLeft);


        //生成第一行显示订单标题
        HSSFRow row = sheet.createRow(rowNum);
        row.setHeightInPoints(h);
        HSSFCell cell = row.createCell(0);
        cell.setCellStyle(styleLeft);
        HSSFRichTextString text = new HSSFRichTextString("编号：JL-7.5-01("+ DateUtil.convertDateToString(new Date())+")-00"+(Integer.valueOf(ii)+1));
        cell.setCellValue(text);

        row.createCell(1).setCellStyle(style3);
        row.createCell(2).setCellStyle(style3);
        row.createCell(3).setCellStyle(style3);
        row.createCell(4).setCellStyle(style3);
        row.createCell(5).setCellStyle(style3);
        row.createCell(6).setCellStyle(style3);
        row.createCell(7).setCellStyle(style3);

        HSSFCell cell0 = row.createCell(8);
        cell0.setCellStyle(style3);
        HSSFRichTextString text0 = new HSSFRichTextString(bomMap.get("ddmc").toString());
        cell0.setCellValue(text0);
        row.createCell(9).setCellStyle(style3);
        //******************第一行编写结束 ***********************************
        //生成第二行显示三维博艺
        HSSFRow row1 = sheet.createRow(rowNum+1);
        row1.setHeightInPoints((short)h_2);

        //第一行竖向合并两个单元格
        HSSFCell cellTitle = row1.createCell(0);
        cellTitle.setCellStyle(style);
        HSSFRichTextString textTitle = new HSSFRichTextString("工艺过程卡");
        cellTitle.setCellValue(textTitle);

        row1.createCell(1).setCellStyle(style2);
        row1.createCell(2).setCellStyle(style2);
        HSSFCell cellKhbh = row1.createCell(3);
        cellKhbh.setCellStyle(style2);
        HSSFRichTextString textKhbh = new HSSFRichTextString("客户编号");
        cellKhbh.setCellValue(textKhbh);
        HSSFCell cellKhbhnr = row1.createCell(4);
        cellKhbhnr.setCellStyle(style3);
        HSSFRichTextString textKhbhnr = new HSSFRichTextString(bomMap.get("khbh").toString());
        cellKhbhnr.setCellValue(textKhbhnr);

        HSSFCell cellCz = row1.createCell(5);
        cellCz.setCellStyle(style2);
        HSSFRichTextString textCz = new HSSFRichTextString("材质");
        cellCz.setCellValue(textCz);
        HSSFCell cellCznr = row1.createCell(6);
        cellCznr.setCellStyle(style3);
        HSSFRichTextString textCznr = new HSSFRichTextString(bomMap.get("clmc").toString());
        cellCznr.setCellValue(textCznr);

        HSSFCell celljhrq = row1.createCell(7);
        celljhrq.setCellStyle(style2);
        HSSFRichTextString textjhrq = new HSSFRichTextString("交货日期");
        celljhrq.setCellValue(textjhrq);
        HSSFCell celljhrqnr = row1.createCell(8);
        celljhrqnr.setCellStyle(style3);
        HSSFRichTextString textjhrqnr = new HSSFRichTextString(bomMap.get("jhdate").toString());
        celljhrqnr.setCellValue(textjhrqnr);

        row1.createCell(9).setCellStyle(style2);

        /********第三行*********************************************/
        HSSFRow row2 = sheet.createRow(rowNum+2);
        row2.setHeightInPoints((short)h_2);
        HSSFCell cellTitle1 = row2.createCell(0);
        cellTitle1.setCellStyle(style);

        row2.createCell(1).setCellStyle(style2);
        row2.createCell(2).setCellStyle(style2);

        HSSFCell cellljmc = row2.createCell(3);
        cellljmc.setCellStyle(style2);
        HSSFRichTextString textljmc = new HSSFRichTextString("零件名称");
        cellljmc.setCellValue(textljmc);
        HSSFCell cellljmcnr = row2.createCell(4);
        cellljmcnr.setCellStyle(style3);
        HSSFRichTextString textljmcnr = new HSSFRichTextString(bomMap.get("zddmc").toString());
        cellljmcnr.setCellValue(textljmcnr);

        HSSFCell cellTz = row2.createCell(5);
        cellTz.setCellStyle(style2);
        HSSFRichTextString textTz = new HSSFRichTextString("图号");
        cellTz.setCellValue(textTz);
        HSSFCell cellTznr = row2.createCell(6);
        cellTznr.setCellStyle(style3);
        HSSFRichTextString textTznr = new HSSFRichTextString(bomMap.get("ddtz")==null?"":bomMap.get("ddtz").toString());
        cellTznr.setCellValue(textTznr);

        HSSFCell cellcount = row2.createCell(7);
        cellcount.setCellStyle(style2);
        HSSFRichTextString textcount = new HSSFRichTextString("零件数量");
        cellcount.setCellValue(textcount);
        HSSFCell celltextcountnr = row2.createCell(8);
        celltextcountnr.setCellStyle(style3);
        HSSFRichTextString texttextcountnr = new HSSFRichTextString(bomMap.get("jgsl").toString());
        celltextcountnr.setCellValue(texttextcountnr);

        row2.createCell(9).setCellStyle(style2);

        //产生表格标题行
        HSSFRow row3 = sheet.createRow(rowNum+3);

        row3.setHeightInPoints((short)h_2);
        for(int i = 0; i<headers.length;i++){
            HSSFCell cell5 = row3.createCell(i);
            cell5.setCellStyle(style2);
            HSSFRichTextString text5 = new HSSFRichTextString(headers[i]);
            cell5.setCellValue(text5);
        }

        List gygxlist = selectDService.queryForList(gygxSql);
        List blList=selectDService.queryForList(blsql);


        //填写备料内容
        for (int i=0;i<blList.size();i++) {
            Map<String,Object> map = (Map<String, Object>) blList.get(i);
            HSSFRow rowCont = sheet.createRow(i+rowNum+4);
            Region region23 = new Region(i+rowNum+4, (short) 2,i+rowNum+4, (short)3);
            sheet.addMergedRegion(region23);
            int j = 0;
            Object value = null;
            for(String key:map.keySet())
            {
                value=map.get(key);

                if(value==null)
                {
                    value="";
                }
                if (key.equals("rownum")) {
                    value = i+1;
                }
                HSSFCell hc=rowCont.createCell(j++);
                hc.setCellStyle(style3);
                hc.setCellValue(String.valueOf(value));

                if(key.equals("gynr"))
                {
                    hc.setCellStyle(styleLeft);
                }
            }
        }
        int whiteRow=16-gygxlist.size();

        //填写工艺内容
        for (int i=0;i<gygxlist.size();i++) {
            Map<String,Object> map = (Map<String, Object>) gygxlist.get(i);
            HSSFRow rowCont = sheet.createRow(i+rowNum+5);
            Region region23 = new Region(i+rowNum+5, (short) 2,i+rowNum+5, (short)3);
            sheet.addMergedRegion(region23);
            int j = 0;
            Object value = null;
            for(String key:map.keySet())
            {
                value=map.get(key);

                if(value==null)
                {
                    value="";
                }
                if (key.equals("rownum")) {
                    value = i+2;
                }
                HSSFCell hc=rowCont.createCell(j++);
                hc.setCellStyle(style3);
                hc.setCellValue(String.valueOf(value));

                if(key.equals("gynr"))
                {
                    hc.setCellStyle(styleLeft);
                }
                //如果
                if(value.toString().trim().length()>14)
                {
                        int strLength=(value.toString().replaceAll("[^\\x00-\\xff]", "**")).length();
                        int hr=(int)Math.ceil(Double.valueOf(strLength/28+1));//所需行数
                        rowCont.setHeightInPoints((short)(h*hr));
                        if(whiteRow>0) {
                            whiteRow = whiteRow - (hr - 1);
                        }
                }
            }
        }
            //如果有表面处理内容则在工艺卡最后添加
        if(!bmcl.equals(""))
        {
            if(gygxlist.size()>0) {
                Map<String, Object> map = (Map<String, Object>) gygxlist.get(0);
                row = sheet.createRow(rowNum + 5 + gygxlist.size());
                Region region23 = new Region(rowNum + 5 + gygxlist.size(), (short) 2,  rowNum + 5 + gygxlist.size(), (short) 3);
                sheet.addMergedRegion(region23);
                int j = 0;
                Object value = bmcl;
                for (String key : map.keySet()) {
                    HSSFCell hc = row.createCell(j++);
                    if(j==2)
                    {
                        hc.setCellValue("表面处理");
                    }
                    if(j==3)
                    {
                        hc.setCellValue(value.toString());
                    }
                    hc.setCellStyle(style3);
                }
            }else{
                row = sheet.createRow( rowNum + 5 + gygxlist.size());
                Region region23 = new Region( rowNum + 5 + gygxlist.size(), (short) 2,  rowNum + 5 + gygxlist.size(), (short) 3);
                sheet.addMergedRegion(region23);
                for(int j=0;j<headers.length;j++)
                {
                    HSSFCell hc=row.createCell(j++);
                    if(j==2)
                    {
                        hc.setCellValue("表面处理");
                    }
                    if(j==3)
                    {
                        hc.setCellValue(bmcl);
                    }
                    hc.setCellStyle(style3);
                }
            }
        }else{
            row = sheet.createRow( rowNum + 5 + gygxlist.size());
            Region region23 = new Region( rowNum + 5 + gygxlist.size(), (short) 2,  rowNum + 5 + gygxlist.size(), (short) 3);
            sheet.addMergedRegion(region23);
            for(int j=0;j<headers.length;j++)
            {
                HSSFCell hc=row.createCell(j++);
                hc.setCellValue("");
                hc.setCellStyle(style3);
            }
        }
        //补充空白格
        for (int i=0;i<whiteRow;i++) {
            if(gygxlist.size()>0) {
                Map<String, Object> map = (Map<String, Object>) gygxlist.get(0);
                row = sheet.createRow(i + rowNum + 6 + gygxlist.size());
                Region region23 = new Region(i + rowNum + 6 + gygxlist.size(), (short) 2, i + rowNum + 6 + gygxlist.size(), (short) 3);
                sheet.addMergedRegion(region23);
                int j = 0;
                Object value = null;
                for (String key : map.keySet()) {
                    HSSFCell hc = row.createCell(j++);
                    hc.setCellStyle(style3);
                }
            }else{
                row = sheet.createRow(i + rowNum + 6 + gygxlist.size());
                Region region23 = new Region(i + rowNum + 6 + gygxlist.size(), (short) 2, i + rowNum + 6 + gygxlist.size(), (short) 3);
                sheet.addMergedRegion(region23);
                for(int j=0;j<headers.length;j++)
                {
                    HSSFCell hc=row.createCell(j++);
                    hc.setCellStyle(style3);
                }
            }
        }

        Region region21 = new Region(rowNum+5+gygxlist.size()+whiteRow, (short) 0,rowNum+5+gygxlist.size()+whiteRow, (short)9);
        sheet.addMergedRegion(region21);
        Region region22 = new Region(rowNum+6+gygxlist.size()+whiteRow, (short) 0,rowNum+6+gygxlist.size()+whiteRow, (short)9);
        sheet.addMergedRegion(region22);
        Region region23 = new Region(rowNum+7+gygxlist.size()+whiteRow, (short) 0,rowNum+7+gygxlist.size()+whiteRow, (short)9);
        sheet.addMergedRegion(region23);

        //结尾处签字行
        HSSFRow row4 = sheet.createRow(rowNum+5+gygxlist.size()+whiteRow);
        row4.setHeightInPoints(h);
        HSSFCell cellqz = row4.createCell(0);
        cellqz.setCellStyle(styleLeft);
        HSSFRichTextString textqz = new HSSFRichTextString("标准会签：                  工艺会签：                    质量会签：                      工艺编制：李勇                   校对：");
        cellqz.setCellValue(textqz);
        row4.createCell(1).setCellStyle(style3);
        row4.createCell(2).setCellStyle(style3);
        row4.createCell(3).setCellStyle(style3);
        row4.createCell(4).setCellStyle(style3);
        row4.createCell(5).setCellStyle(style3);
        row4.createCell(6).setCellStyle(style3);
        row4.createCell(7).setCellStyle(style3);
        row4.createCell(8).setCellStyle(style3);
        row4.createCell(9).setCellStyle(style3);
        //结尾处签字行
        HSSFRow row5 = sheet.createRow(rowNum+6+gygxlist.size()+whiteRow);
        row5.setHeightInPoints(h);
        HSSFCell cellqz2 = row5.createCell(0);
        cellqz2.setCellStyle(styleLeft);
        HSSFRichTextString textqz2 = new HSSFRichTextString("审   定：                          批   准：                     临时更改：                      更改批准：");
        cellqz2.setCellValue(textqz2);
        row5.createCell(1).setCellStyle(style3);
        row5.createCell(2).setCellStyle(style3);
        row5.createCell(3).setCellStyle(style3);
        row5.createCell(4).setCellStyle(style3);
        row5.createCell(5).setCellStyle(style3);
        row5.createCell(6).setCellStyle(style3);
        row5.createCell(7).setCellStyle(style3);
        row5.createCell(8).setCellStyle(style3);
        row5.createCell(9).setCellStyle(style3);
        //结尾处签字行
        HSSFRow row6 = sheet.createRow(rowNum+7+gygxlist.size()+whiteRow);
        row6.setHeightInPoints(h);
        HSSFCell cellsm = row6.createCell(0);
        cellsm.setCellStyle(styleLeft);
        HSSFRichTextString textsm = new HSSFRichTextString("本工艺卡片由操作者妥善保管，加工完交验后并填写工序交接时间随图纸一同转入下道工序，最终由检验负责收回备案");
        cellsm.setCellValue(textsm);
        row6.createCell(1).setCellStyle(style3);
        row6.createCell(2).setCellStyle(style3);
        row6.createCell(3).setCellStyle(style3);
        row6.createCell(4).setCellStyle(style3);
        row6.createCell(5).setCellStyle(style3);
        row6.createCell(6).setCellStyle(style3);
        row6.createCell(7).setCellStyle(style3);
        row6.createCell(8).setCellStyle(style3);
        row6.createCell(9).setCellStyle(style3);

        newRowNum=Integer.valueOf(10+gygxlist.size()+whiteRow);
        return newRowNum;
    }
}





