package com.kfighter.dfm.util;

import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
* 获取系统properties文件处理类
* 类修改者	修改日期
* 修改说明
* <p>Title: PropertiesUtils.java</p>
* <p>Description:清大海辉科技开发平台</p>
* <p>Copyright: Copyright (c) 2006</p>
* <p>Company:北京清大海辉科技有限公司</p>
* @author Kfighter  
* @date Dec 15, 2010 3:21:07 PM
* @version V0.1
*/
public class PropertiesUtils {
	private static final Logger log = Logger.getLogger(PropertiesUtils.class);
	private static String config = "/config.properties";
	private static Properties props;
	/**
	* 根据文件路径获取*.properties文件
	* Kfighter    Dec 15, 2010
	* 修改者名字 修改日期
	* 修改内容
	* @param filePath
	* @return   
	* @return Properties    
	* @throws
	*/
	public static Properties getProperties() {
		try {
			if(null == props){
				props = new Properties();
			}
			props.load(PropertiesUtils.class.getResourceAsStream(config));
			return props;
		} catch (IOException e) {
			log.error("找不到对应的配置文件！");
			
		}
		return props;
	}
}
