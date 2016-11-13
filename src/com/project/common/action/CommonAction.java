package com.project.common.action;

import com.opensymphony.xwork2.ActionContext;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.json.JSONException;
import com.project.util.json.JSONObject;
import net.sf.json.JSONArray;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;

import java.util.Iterator;
import java.util.List;

/**
 * Created by Founder on 2015/10/18.
 */
public class CommonAction {
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
        String pid=Request.getParameter("pid");
        String ssbz= ActionContext.getContext().getSession().get("userssbz").toString();
        String sql="select * from scglxt_t_cd where cdfjd='"+pid+"' and id in (select cdid from scglxt_t_qxgl where bzid='"+ssbz+"')";

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
                String value=lom.get(key).toString();

                json.append("\""+key+"\":\""+value+"\",");
            }

            sql="select * from scglxt_t_cd where cdfjd='"+lom.get("id")+"' and id in (select cdid from scglxt_t_qxgl where bzid='"+ssbz+"')";

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

}
