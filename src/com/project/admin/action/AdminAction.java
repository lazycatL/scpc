package com.project.admin.action;

import com.opensymphony.xwork2.ActionContext;
import com.project.admin.bean.User;
import com.project.base.service.SelectDataService;
import com.project.util.json.JSONArray;
import com.project.util.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.struts2.ServletActionContext;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.Map;

/**
 * Created by apple on 16/5/20.
 */
public class AdminAction {

    private SelectDataService selectDataService;

    public SelectDataService getSelectDataService() {
        return selectDataService;
    }

    public void setSelectDataService(SelectDataService selectDataService) {
        this.selectDataService = selectDataService;
    }
    /**
     * @description: 该类用于登录处理逻辑
     * @author dafu.wei
     * @param{}
     * @return{}
     * @version 1.02
     */
    public void login() {
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setHeader("Access-Control-Allow-Origin","*");
            response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
            response.setHeader("Access-Control-Max-Age", "3600");
            response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Authorization, X-Requested-With, Origin, Accept");
            response.setHeader("Access-Control-Allow-Credentials","true");
            response.setContentType("application/x-www-form-urlencoded;charset=utf-8");
            response.setCharacterEncoding("UTF-8");
            // 得到reuest中参数

            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String type=request.getParameter("type");

            User user = null;
            if(userName!=null&&!userName.equals("")){
                // 查询用户是否存在
                user = checkUser(userName, passWord);
            }else{
                if(type==null) {
                    request.getRequestDispatcher("login.jsp").forward(request,
                            response);
                }else{
                    response.getWriter().write("error");
                }
            }

            // 用户存在记录cookies
            if (user != null) {
                String name= URLEncoder.encode(user.getRymc(),"UTF-8");
                String bzmc= URLEncoder.encode(user.getBzmc(),"UTF-8");
                if(type==null) {
                    ActionContext.getContext().getSession().put("username",user.getRymc());//在session中放入用户真实名
                    ActionContext.getContext().getSession().put("userid",user.getId());
                    ActionContext.getContext().getSession().put("userssbz",user.getSsbz());
                    ActionContext.getContext().getSession().put("userbzmc",user.getBzmc());

                    Cookie cookie=new Cookie("userName",name);
                    Cookie cookie2=new Cookie("userSsbz",user.getSsbz());
                    Cookie cookie3=new Cookie("userBzmc",bzmc);
                    response.addCookie(cookie);
                    response.addCookie(cookie2);
                    response.addCookie(cookie3);
                    request.getRequestDispatcher("index.jsp").forward(request,
                            response);
                }else{
                    //创建JSONObject对象
                    JSONObject json = new JSONObject();
                    json.put("result", "success");
                    JSONObject userJson = new JSONObject();
                    userJson.put("id", user.getId());
                    userJson.put("username", name);
                    userJson.put("name", name);
                    userJson.put("bzmc",user.getBzmc());
                    userJson.put("bzid",user.getSsbz());
                    userJson.put("password", user.getPassword());
                    userJson.put("avatar", user.getRyzp());

                    json.put("user",userJson);
                    response.getWriter().write(json.toString());
                }
                return;
            } else {
                // 查询对应用户失败传递对应信息
                if(type==null) {
                    request.setAttribute("message", "您输入的用户名或者密码错误请重试！");
                    request.getRequestDispatcher("login.jsp").forward(request,
                            response);
                    return;
                }else{
                    response.getWriter().write("error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public User checkUser(String userName, String password) {

        String sql="SELECT  ry.ID, RYMC,RYNL,SSBZ,BZMC,DQGZ,PASSWORD,RYZP FROM SCGLXT_T_RY ry,scglxt_t_bz bz WHERE ry.`ssbz`=bz.`id` AND RYMC = '"+userName+"' AND PASSWORD='"+password+"'";
        SqlRowSet rs = this.selectDataService.getSqlRowSet(sql);
        User user = null;
        if (rs.next()) {
            user = new User();
            user.setId(rs.getString("ID"));
            user.setRymc(rs.getString("RYMC"));
            user.setSsbz(rs.getString("SSBZ"));
            user.setPassword(rs.getString("PASSWORD"));
            user.setBzmc(rs.getString("BZMC"));
            user.setRynl(rs.getString("RYNL"));
            user.setRyzp(rs.getString("RYZP"));
            return user;
        } else {

            return null;
        }
    }
}
