package com.kings.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class DownloadFileUtils {
    public static Logger logger = Logger.getLogger(DownloadFileUtils.class);

    public static void download(String path, HttpServletResponse response) {
        path = "/Users/davewang/active/logs/AssetService1-gc.log";
        int bytesum = 0;
        int byteread = 0;
        InputStream in = null;
        OutputStream out = null;
        try {
            File file = FileUtils.readFile(path);
            String filename = file.getName();
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
            in = new BufferedInputStream(new FileInputStream(file));
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            response.setContentType("application/octet-stream");
            out = response.getOutputStream();
            byte[] buffer = new byte[1204];
            while ((byteread = in.read(buffer)) != -1) {
                bytesum += byteread;
                out.write(buffer, 0, byteread);
            }
        } catch (IOException ex) {
            logger.error("Download file failed, filePath=" + path, ex);
        } finally {
            try {
                if (null != in) {
                    in.close();
                }
                if (null != out) {
                    out.close();
                    out.flush();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
