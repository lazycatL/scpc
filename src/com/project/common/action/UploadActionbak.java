package com.project.common.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.opensymphony.xwork2.ActionSupport;
import com.project.base.service.SelectDataService;
import com.project.util.WebUtils;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;
/**
 * 资源导入，根据上传Excel读取数据插入到数据库
 */
public class UploadActionbak extends ActionSupport {
	
	private SelectDataService selectDataService;
	private static final long serialVersionUID = 1L;

	public SelectDataService getSelectDataService() {
		return selectDataService;
	}

	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 上传图纸
	 */
	public void uploadTz(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        ServletContext servletContext = ServletActionContext.getServletContext();
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            //上传文件的保存路径
            String configPath = "uploadFile";

            String dirTemp = "uploadFile/temp";

            String dirName = "file";

            String type=request.getParameter("type");
            String ddid=request.getParameter("ddbh");
            String ddbh="";
            //文件保存目录路径
            //String savePath = "E:/";
            if(type.equals("excel"))
            {
                configPath+="\\excel";
            }
            if(type.equals("tz"))//如果上传的是图纸，则保存路径为tz/ddbh/tzmc
            {
                if (!ddid.equals("")) {
                    String ddbhSql="Select xmname from scglxt_t_dd where id='"+ddid+"'";
                    List<ListOrderedMap> list =selectDataService.queryForList(ddbhSql);
                    if(list.size()>0) {
                        configPath += "\\ddtz\\" + ddbh;
                    }else{
                        configPath += "\\ddtz\\" + ddid;
                    }
                }
            }
        String savePath = servletContext.getRealPath("/") + configPath;

        // 临时文件目录
        String tempPath = servletContext.getRealPath("/") + dirTemp;


        System.out.println("------->"+savePath);
        //创建文件夹
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        /**tempPath += "/" + ymd + "/";  **/
        //创建临时文件夹
        File dirTempFile = new File(tempPath);
        if (!dirTempFile.exists()) {
            dirTempFile.mkdirs();
        }

        DiskFileItemFactory  factory = new DiskFileItemFactory();
        factory.setSizeThreshold(20 * 1024 * 1024); //设定使用内存超过5M时，将产生临时文件并存储于临时目录中。
        factory.setRepository(new File(tempPath)); //设定存储临时文件的目录。
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");

            List items = upload.parseRequest(request);
            System.out.println("items = " + items);
            Iterator itr = items.iterator();

            while (itr.hasNext())
            {
                FileItem item = (FileItem) itr.next();
                String fileName = item.getName();
                if(type.equals("excel"))
                {
                    fileName=getRandomString(10)+"_"+fileName;
                }
                long fileSize = item.getSize();
                if (!item.isFormField()) {
                    String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
                    //  String newFileName = fileName.split(".")[0]  + "_"+ df.format(new Date()) + "." + fileExt;
                    try{
                        File uploadedFile = new File(savePath, fileName);

                        OutputStream os = new FileOutputStream(uploadedFile);
                        InputStream is = item.getInputStream();
                        byte buf[] = new byte[1024];//可以修改 1024 以提高读取速度
                        int length = 0;
                        while( (length = is.read(buf)) > 0 ){
                            os.write(buf, 0, length);
                        }
                        //关闭流
                        os.flush();
                        os.close();
                        is.close();
                        PrintWriter writer=null;
                        writer=response.getWriter();
                        //writer.print(fileName);
                        writer.write(savePath+"\\"+fileName);
                        writer.flush();
                        writer.close();
                        if(type.equals("tz"))//如果上传的是图纸，则保存路径为tz/ddbh/tzmc
                        {
                            if (!ddid.equals("")) {
                                String id= WebUtils.getRandomId();
                                String insertSql="insert into scglxt_t_dd_tz(id,ssdd,tzlx,tzmc,tzdz) values('"+id+"','"+ddid+"','"+fileName.split(".")[1]+"','"+fileName.split(".")[0]+"','scpc/uploadFile/"+ddbh+"/"+fileName+"')";
                                selectDataService.execute(insertSql);
                            }
                        }
                        System.out.println("上传成功！路径："+savePath+"/"+fileName);
                        out.print(savePath+"/"+fileName);

                    }catch(Exception e){
                        e.printStackTrace();
                    }
                }else {
                    String filedName = item.getFieldName();
                    if(filedName.equals("customData")){
                        System.out.println("用户自定义参数===============");
                        System.out.println("FieldName："+filedName);
                        System.out.println(URLDecoder.decode(URLDecoder.decode(item.getString(), "utf-8"), "utf-8"));
                    }else if(filedName.equals("tailor")){
                        System.out.println("裁剪后的参数===============");
                        System.out.println("FieldName："+filedName);
                        System.out.println(new String(item.getString().getBytes("iso-8859-1"), "utf-8"));
                        // 获得裁剪部分的坐标和宽高
                        System.out.println("String："+item.getString());
                    }
                }
            }
            out.flush();
            out.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static String getRandomString(int length) { //length表示生成字符串的长度
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }

}
