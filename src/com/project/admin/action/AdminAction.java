package com.project.admin.action;

import com.opensymphony.xwork2.ActionContext;
import com.project.admin.bean.User;
import com.project.base.service.SelectDataService;
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
            // 得到reuest中参数
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            User user = null;
            if(userName!=null&&!userName.equals("")){
                // 查询用户是否存在
                user = checkUser(userName, passWord);
            }else{
                request.getRequestDispatcher("login.jsp").forward(request,
                        response);
            }

            // 用户存在记录cookies
            if (user != null) {
                ActionContext.getContext().getSession().put("username",user.getRymc());//在session中放入用户真实名
                ActionContext.getContext().getSession().put("userid",user.getId());
                ActionContext.getContext().getSession().put("userssbz",user.getSsbz());
                String name= URLEncoder.encode(user.getRymc(),"UTF-8");
                Cookie cookie=new Cookie("userName",name);
                Cookie cookie2=new Cookie("userSsbz",user.getSsbz());
                response.addCookie(cookie);
                response.addCookie(cookie2);
                request.getRequestDispatcher("index.jsp").forward(request,
                        response);
                return;
            } else {
                // 查询对应用户失败传递对应信息
                request.setAttribute("message", "您输入的用户名或者密码错误请重试！");
                request.getRequestDispatcher("login.jsp").forward(request,
                        response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public User checkUser(String userName, String password) {

        String sql = "SELECT  ID, RYMC,RYNL,SSBZ,DQGZ,PASSWORD FROM SCGLXT_T_RY WHERE RYMC = '"+userName+"' AND PASSWORD='"+password+"'";
        SqlRowSet rs = this.selectDataService.getSqlRowSet(sql);
        User user = null;
        if (rs.next()) {
            user = new User();
            user.setId(rs.getString("ID"));
            user.setRymc(rs.getString("RYMC"));
            user.setSsbz(rs.getString("SSBZ"));
            user.setRynl(rs.getString("RYNL"));
            return user;
        } else {

            return null;
        }
    }
}
