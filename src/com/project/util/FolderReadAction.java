package com.project.util;

import com.project.commonModel.util.Response;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Servlet implementation class UploadAction
 */
public class FolderReadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;



    /**
     * @see javax.servlet.http.HttpServlet#HttpServlet()
     */
    public FolderReadAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String ddname=request.getParameter("ddid");//表格ID  0122
        StringBuilder json=new StringBuilder();

        String filepath = this.getServletContext().getRealPath("/") +"uploadFile\\ddtz\\"+ ddname;
        File file = new File(filepath);
        System.out.println(filepath);
        List list = new ArrayList();
        File[] files=file.listFiles();
        String name = "";
        if(files.length>0) {
            json.append("[");
            for (int i = 0; i < files.length; i++) {
                if (files[i].isFile()) {
                   // json.append("{\"tpdz\":\"" + filepath+"\\"+files[i].getName()+ "\"},");
                    json.append("{\"tpdz\":\"" + ddname+"#"+files[i].getName()+ "\"},");
                   // list.add(files[i].getName());
                }
            }
            json.delete(json.length()-1,json.length());
            json.append("]");
        }else{
            json.append("[]");
        }

        response.getWriter().write(json.toString());
	}
}
