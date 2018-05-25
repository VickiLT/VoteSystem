package com.vote.controller;

import com.vote.util.FileUtil;
import com.vote.util.HttpUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

/**
 * Created by sunwe on 2018/5/17.
 */
@Controller
@RequestMapping("/file")
public class FileController {

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    @ResponseBody
    public String uploadFiles(@RequestParam("file_upload") MultipartFile[] files,HttpServletRequest request) {
        boolean result = false;
        String filePath = request.getSession().getServletContext().getRealPath("/uploadFiles/");
        String realPath;
        for(int i=0;i<files.length;i++){
            if (!files[i].isEmpty()) {
                String uniqueName=files[i].getOriginalFilename();//得到文件名
//                String uuid = UUID.randomUUID().toString().replace("-","");
//                String uuidFileName = uuid + uniqueName;
//                String fileType = uniqueName.split("[.]")[1];
//                File f = new File(filePath+"/"+uuid+"."+fileType);
                try {
                    FileUtil.upFile(files[i].getInputStream(), uniqueName, filePath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                result = true;
            }
        }
        return String.valueOf(result);
    }

    @RequestMapping("/downFile")
    public void downFile(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

        // 得到要下载的文件名
        request.setCharacterEncoding("UTF-8");
        String fileName = request.getParameter("filename");
        try {
            //fileName = new String(fileName.getBytes("iso8859-1"), "UTF-8");
            // 获取上传文件的目录
            ServletContext sc = request.getSession().getServletContext();
            // 上传位置
            String fileSaveRootPath = sc.getRealPath(System.getProperty("file.separator")+"uploadFiles");

            System.out.println(fileSaveRootPath + System.getProperty("file.separator") + fileName);
            // 得到要下载的文件
            File file = new File(fileSaveRootPath + System.getProperty("file.separator") + fileName);

            // 如果文件不存在
            if (!file.exists()) {
                request.setAttribute("message", "您要下载的资源已被删除！！");
                System.out.println("您要下载的资源已被删除！！");
                return;
            }
            // 处理文件名
            String realname = fileName.substring(fileName.indexOf("_") + 1);
            response.setContentType("application/octet-stream");
            boolean isMSIE = HttpUtils.isMSBrowser(request);
            if (isMSIE) {
               //IE浏览器的乱码问题解决
                realname = URLEncoder.encode(realname, "UTF-8");
            } else {
               //万能乱码问题解决
                realname = new String(realname.getBytes("UTF-8"), "ISO-8859-1");
            }
            // 设置响应头，控制浏览器下载该文件
            response.setHeader("content-disposition", "attachment;filename="
                    + realname);
            // 读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(fileSaveRootPath + System.getProperty("file.separator") + fileName);
            // 创建输出流
            OutputStream out = response.getOutputStream();
            // 创建缓冲区
            byte buffer[] = new byte[1024];
            int len = 0;
            // 循环将输入流中的内容读取到缓冲区当中
            while ((len = in.read(buffer)) > 0) {
                // 输出缓冲区的内容到浏览器，实现文件下载
                out.write(buffer, 0, len);
            }
            // 关闭文件输入流
            in.close();
            // 关闭输出流
            out.close();
        } catch (Exception e) {

        }
    }
}
