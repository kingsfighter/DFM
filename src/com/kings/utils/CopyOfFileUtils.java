package com.kings.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * File tool
 * 
 * @author dave.wang
 */
public class CopyOfFileUtils {
    public static Set<String> sets = new HashSet<String>();

    public static void main(String[] args) {
        String folderPath = "/opt/active/logs/";
        String[] list = readFolder(folderPath);
        for(String str : list){
            System.out.println(folderPath + str);
        }
    }

    /**
     * read file
     * 
     * @param strFilePath
     * @return
     */
    public static File readFile(String fileName) {
        File file = new File(fileName);
        if (!file.exists()) {
            return null;
        }
        InputStream in = null;
        try {
            byte[] tempbytes = new byte[1024];
            int byteread = 0;
            in = new FileInputStream(fileName);
            while ((byteread = in.read(tempbytes)) != -1) {
                // System.out.write(tempbytes, 0, byteread);
                // TODO output file content
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e1) {
                }
            }
        }
        return file;
    }

    /**
     * read folder, get sub files(single level, the first level)
     * 
     * @param strFilePath
     * @return
     */
    public static String[] readFolder(String strFolderPath) {
        String[] filePaths = new String[100];
        File folder = new File(strFolderPath);
        if (!folder.exists() || !folder.isDirectory()) {
            return filePaths;
        }
        String[] subFiles = folder.list();
        if (null == subFiles || subFiles.length < 1) {
            return filePaths;
        }
        return filePaths;
    }

}
