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

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;

/**
 * File tool
 * 
 * @author dave.wang
 */
public class FileUtils {
    public static Logger logger = Logger.getLogger(FileUtils.class);
    public static Set<String> sets = new HashSet<String>();

    public static void main(String[] args) {
        String folderPath = "/opt/active/logs/";
        List<String> list = readFolder(folderPath);
        for(String str : list){
            System.out.println(folderPath + str);
        }
    }

    /**
     * create folder
     * 
     * @param strFilePath
     */
    public boolean mkdirFolder(String strFilePath) {
        boolean bFlag = false;
        try {
            File file = new File(strFilePath.toString());
            if (!file.exists()) {
                bFlag = file.mkdir();
            }
        } catch (Exception e) {
            logger.error("create new folder failed," + e.getLocalizedMessage(), e);
        }
        return bFlag;
    }

    public boolean createFile(String strFilePath, String strFileContent) {
        boolean bFlag = false;
        try {
            File file = new File(strFilePath.toString());
            if (!file.exists()) {
                bFlag = file.createNewFile();
            }
            if (bFlag == Boolean.TRUE) {
                FileWriter fw = new FileWriter(file);
                PrintWriter pw = new PrintWriter(fw);
                pw.println(strFileContent.toString());
                pw.close();
            }
        } catch (Exception e) {
            logger.error("create new file failed," + e.getLocalizedMessage(), e);
            e.printStackTrace();
        }
        return bFlag;
    }

    /**
     * remove file
     * 
     * @param strFilePath
     * @return
     */
    public static boolean removeFile(String strFilePath) {
        boolean result = false;
        if (strFilePath == null || "".equals(strFilePath)) {
            return result;
        }
        File file = new File(strFilePath);
        if (file.isFile() && file.exists()) {
            result = file.delete();
            if (result == Boolean.TRUE) {
                logger.debug("[REMOE_FILE:" + strFilePath + "remove successfully!]");
            } else {
                logger.debug("[REMOE_FILE:" + strFilePath + "remove failed!]");
            }
        }
        return result;
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
    public static List<String> readFolder(String strFolderPath) {
        List<String> filePaths = new ArrayList<String>();
        File folder = new File(strFolderPath);
        if (!folder.exists() || !folder.isDirectory()) {
            return filePaths;
        }
        String[] subFiles = folder.list();
        if (null == subFiles || subFiles.length < 1) {
            return filePaths;
        }
        CollectionUtils.addAll(filePaths, subFiles);
        return filePaths;
    }

    /**
     * remove folder(contains sub folders and files)
     * 
     * @param strFolderPath
     * @return
     */
    public static boolean removeFolder(String strFolderPath) {
        boolean bFlag = false;
        try {
            if (strFolderPath == null || "".equals(strFolderPath)) {
                return bFlag;
            }
            File file = new File(strFolderPath.toString());
            bFlag = file.delete();
            if (bFlag == Boolean.TRUE) {
                logger.debug("[REMOE_FOLDER:" + file.getPath() + "remove successfully!]");
            } else {
                logger.debug("[REMOE_FOLDER:" + file.getPath() + "remove failed!]");
            }
        } catch (Exception e) {
            logger.error("FLOADER_PATH:" + strFolderPath + "remove folder failed!");
            e.printStackTrace();
        }
        return bFlag;
    }

    /**
     * remove all files
     * 
     * @param strPath
     */
    public static void removeAllFile(String strPath) {
        File file = new File(strPath);
        if (!file.exists()) {
            return;
        }
        if (!file.isDirectory()) {
            return;
        }
        String[] fileList = file.list();
        File tempFile = null;
        for (int i = 0; i < fileList.length; i++) {
            if (strPath.endsWith(File.separator)) {
                tempFile = new File(strPath + fileList[i]);
            } else {
                tempFile = new File(strPath + File.separator + fileList[i]);
            }
            if (tempFile.isFile()) {
                tempFile.delete();
            }
            if (tempFile.isDirectory()) {
                removeAllFile(strPath + "/" + fileList[i]);//
                removeFolder(strPath + "/" + fileList[i]);//
            }
        }
    }

    public static void copyFile(String oldPath, String newPath) {
        try {
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPath);
            if (oldfile.exists()) {
                InputStream inStream = new FileInputStream(oldPath); //
                FileOutputStream fs = new FileOutputStream(newPath);
                byte[] buffer = new byte[1444];
                while ((byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread;
                    System.out.println(bytesum);
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();
                logger.debug("[COPY_FILE:" + oldfile.getPath() + "copy file successfully!]");
            }
        } catch (Exception e) {
            logger.error("copy single file failed," + e.getMessage(), e);
        }
    }

    public static void copyFolder(String oldPath, String newPath) {
        try {
            (new File(newPath)).mkdirs();
            File a = new File(oldPath);
            String[] file = a.list();
            File temp = null;
            for (int i = 0; i < file.length; i++) {
                if (oldPath.endsWith(File.separator)) {
                    temp = new File(oldPath + file[i]);
                } else {
                    temp = new File(oldPath + File.separator + file[i]);
                }
                if (temp.isFile()) {
                    FileInputStream input = new FileInputStream(temp);
                    FileOutputStream output = new FileOutputStream(newPath + "/ " + (temp.getName()).toString());
                    byte[] b = new byte[1024 * 5];
                    int len;
                    while ((len = input.read(b)) != -1) {
                        output.write(b, 0, len);
                    }
                    output.flush();
                    output.close();
                    input.close();
                    logger.debug("[COPY_FILE:" + temp.getPath() + "copy file successfully!]");
                }
                if (temp.isDirectory()) {
                    copyFolder(oldPath + "/ " + file[i], newPath + "/ " + file[i]);
                }
            }
        } catch (Exception e) {
            logger.error("copy whole folder content failed!");
        }
    }

    public static void moveFile(String oldPath, String newPath) {
        copyFile(oldPath, newPath);
        removeFile(oldPath);
    }

    public static void moveFolder(String oldPath, String newPath) {
        copyFolder(oldPath, newPath);
        removeFolder(oldPath);
    }
}
