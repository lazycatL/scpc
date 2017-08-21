package com.project.common.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;
import com.project.util.json.JSONException;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Founder on 2015/10/18.
 */
public class CommonAction extends ActionSupport {
    private static Log log = org.apache.commons.logging.LogFactory.getLog(CommonAction.class);
    private SelectDataService selectDataService;
    public SelectDataService getSelectDataService() {
        return selectDataService;
    }
    public void setSelectDataService(SelectDataService selectDataService) {
        this.selectDataService = selectDataService;
    }


    /**
     * ��ѯ����ֵ��б�
     */
    public void loadSjzdList(){
        String pid =  Request.getParameter("pid") ;
        String sql = "select  id ,mc  from scglxt_tyzd where id like '"+pid+"_%' order by mc ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        Response.write(json);
    }

    /***
     * 加载菜单树Json数据
     */
    public void loadMenuTree() throws JSONException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setHeader("Access-Control-Allow-Origin","*");

        String pid=Request.getParameter("pid");
        String vue=Request.getParameter("vue");
        String ssbz="";
        if(vue!=null && !vue.equals(""))
        {
            pid="0";
            ssbz=Request.getParameter("ssbz");
        }else{
            ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
        }

        String sql="select * from scglxt_t_cd cd where cdfjd='"+pid+"' and id in (select cdid from scglxt_t_qxgl where bzid='"+ssbz+"') order by cd.id";

        List list = this.selectDataService.queryForList(sql);

        StringBuilder json=new StringBuilder();
        json.append("[");

        for(int i=0;i<list.size();i++)
        {
            ListOrderedMap lom=(ListOrderedMap)list.get(i);
            Iterator ksi = lom.keySet().iterator();
            json.append("{");
            while(ksi.hasNext()){
                String key=ksi.next().toString();

                String value="";
                if(lom.get(key)==null)
                {
                    value="";
                }else{
                    value = lom.get(key).toString();
                }

                json.append("\""+key+"\":\""+value+"\",");
            }

            sql="select * from scglxt_t_cd cd where cdfjd='"+lom.get("id")+"' and id in (select cdid from scglxt_t_qxgl where bzid='"+ssbz+"')  order by cd.id";

            List childList=this.selectDataService.queryForList(sql);
            if(childList.size()>0)
            {
                json.append("\"children\":"+JsonObjectUtil.list2Json(childList)+"");
            }else{
                json.append("\"children\":\"\"");
            }
            json.append("},");
        }
        json.delete(json.length()-1,json.length());
        json.append("]");

        Response.write(json.toString());
    }

    /**
     * 设置班组菜单权限时加载菜单数据
     */
    public void getMenu()
    {
        String bzid=Request.getParameter("bzid");
        String sql="SELECT id,cdmc text FROM scglxt_t_cd where cdfjd='0'";
        if(!bzid.equals(""))
        {
            sql="SELECT id,text,STATUS checked FROM (SELECT cd.id,cd.cdmc TEXT,cd.`cdtb` icon,cd.cdfjd, CASE WHEN qx.bzid = '"+bzid+"'  THEN 'true'  END AS STATUS \n" +
                    "  FROM  scglxt_t_cd cd   LEFT JOIN scglxt_t_qxgl qx   ON cd.id = qx.cdid   AND bzid = '"+bzid+"') t1 WHERE cdfjd = '0' ORDER BY id";
        }

        List list = this.selectDataService.queryForList(sql);

        StringBuilder json=new StringBuilder();
        json.append("[");

        for(int i=0;i<list.size();i++)
        {
            ListOrderedMap lom=(ListOrderedMap)list.get(i);
            Iterator ksi = lom.keySet().iterator();
            json.append("{");
            while(ksi.hasNext()){
                String key=ksi.next().toString();
                String value="";
                if(lom.get(key)==null)
                {
                    value="";
                }else{
                    value=lom.get(key).toString();
                }
                if(key.equals("checked"))
                {
                    json.append("\"state\":{\""+key+"\":\""+value+"\"},");
                }else{
                    json.append("\""+key+"\":\""+value+"\",");
                }
            }

            sql="SELECT id,cdmc text FROM scglxt_t_cd where cdfjd='"+lom.get("id")+"'";

            if(!bzid.equals(""))
            {
                sql="SELECT id,text,state state,url FROM (SELECT cd.id,cd.cdmc TEXT,cd.`cdtb` icon,cd.cdfjd,cd.url, CASE WHEN qx.bzid = '"+bzid+"'  THEN '{\"checked\":\"true\"}'  END AS state \n" +
                        "  FROM  scglxt_t_cd cd   LEFT JOIN scglxt_t_qxgl qx   ON cd.id = qx.cdid   AND bzid = '"+bzid+"') t1 WHERE cdfjd='"+lom.get("id")+"' ORDER BY id";
            }
            List childList=this.selectDataService.queryForList(sql);
            if(childList.size()>0)
            {
                json.append("\"nodes\":"+JsonObjectUtil.list2Json(childList)+"");
            }else{
                json.append("\"nodes\":\"\"");
            }
            json.append("},");
        }
        json.delete(json.length()-1,json.length());
        json.append("]");

        Response.write(json.toString().replace("\"{\\\"","{\"").replace("\\\"}\"","\"}").replace("\\\":\\\"","\":\""));
    }

    /***
     * 根据班组ID修改班组所拥有的权限
     */
    public void updateQxgl()
    {
        String bzid=Request.getParameter("bzid");
        String qxsj=Request.getParameter("qxsj");

        qxsj=qxsj.substring(0,qxsj.length()-1);


        String deleteSql="Delete from scglxt_t_qxgl where bzid='"+bzid+"'";

        String insertSql="";

        String[] qxsjArr=qxsj.split(",");

        try {
            selectDataService.delete(deleteSql);
            for (int i = 0; i < qxsjArr.length; i++) {

                String randomId = WebUtils.getRandomId();
                insertSql="Insert into scglxt_t_qxgl (id,bzid,cdid) values('"+randomId+"','"+bzid+"','"+qxsjArr[i]+"')";
                System.out.println(insertSql);
                selectDataService.execute(insertSql);
            }
            Response.write("success");
        }catch (Exception ex)
        {
            Response.write("error");
        }

    }
    /***
     * 获取所有需要提醒的菜单，和提醒事件的个数
     */

    public void getDbsxInfo()
    {
        StringBuilder json=new StringBuilder();

        String sql="select cdmc,cddz,sfts,tstable,tstj from scglxt_t_cd where sfts='1'";

        List list = this.selectDataService.queryForList(sql);
        if(list.size()>0)
        {
            json.append("[");
            for(int i=0;i<list.size();i++)
            {
                json.append("{");
                ListOrderedMap lom=(ListOrderedMap)list.get(i);
                String configSql="select * from "+lom.get("tstable").toString()+" where "+lom.get("tstj");

                if(lom.get("cddz").toString().equals("jgryjg"))
                {
                    String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
                    if(!ssbz.equals("759007553955134000000"))//如果不是管理组就过滤所述班组权限
                    {
                        configSql+=" AND gynr IN (SELECT id FROM `scglxt_t_jggy` WHERE fzbz='"+ssbz+"')";
                    }

                }
                if( lom.get("cddz").toString().equals("bomgl"))
                {
                    configSql="SELECT COUNT(*) COUNT,zddzt FROM  scglxt_t_bom WHERE zddzt IN ('0501','0502') GROUP BY zddzt";

                    List count = this.selectDataService.queryForList(configSql);

                    json.append("\"cddz\":\"" + lom.get("cddz").toString() + "\",");
                    json.append("\"cdmc\":\"" + lom.get("cdmc").toString() + "\",");

                    if (count.size()>0) {
                        ListOrderedMap ddlom=(ListOrderedMap)count.get(0);
                        json.append("\"wkscount\":\"" +(ddlom.get("count")==null?"":ddlom.get("count").toString()) + "\"");
                        if(count.size()>1)
                        {
                            ListOrderedMap ddlom2=(ListOrderedMap)count.get(1);
                            json.append(",\"jxzcount\":\"" +(ddlom2.get("count")==null?"":ddlom2.get("count").toString()) + "\"");
                        }else{
                            json.append(",\"jxzcount\":\"0\"");
                        }
                    } else {
                        json.append("\"wkscount\":\"0\"");
                        json.append(",\"jxzcount\":\"0\"");
                    }
                    json.append("},");
                }else {
                    List count = this.selectDataService.queryForList(configSql);
                    json.append("\"cddz\":\"" + lom.get("cddz").toString() + "\",");
                    json.append("\"cdmc\":\"" + lom.get("cdmc").toString() + "\",");
                    if (count.size()>0) {
                        json.append("\"count\":\"" + count.size() + "\"");
                    } else {
                        json.append("\"count\":\"0\"");
                    }
                    json.append("},");
                }
            }
            json.delete(json.length()-1,json.length());
            json.append("]");
        }else{
            json.append("[]");
        }
        Response.write(json.toString());
    }


    public void getFileByDd()
    {

    }
}
