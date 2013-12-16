package com.website.controller.security;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mlogger.Loggers;
import com.mtoolkit.page.Page;
import com.mtoolkit.util.ArrayUtil;
import com.mtoolkit.util.CopyUtil;
import com.website.controller.BaseController;
import com.website.exception.NotFoundException;
import com.website.exception.SystemException;

@Controller
@RequestMapping("/log")
@RequiresRoles("log:manager")
public class LogController extends BaseController {

	public static final long BATCH_SIZE = 1024L;
	private final Loggers logger = Loggers.getLoggers(getClass());
	
    @RequestMapping(method=RequestMethod.GET)
    public String index(ModelMap modelMap) {
        return "log/list";
    }
    
    @ResponseBody
    @RequestMapping(value="/list", method=RequestMethod.POST)
	public Object showList(Page<LogFile> page, String fileName) {
        File[] logFiles = doGetLogDir().listFiles();
        
        if (logFiles != null && logFiles.length > 0) {
	        page.setTotalData(logFiles.length);
	        int pageSize = page.getToIndex() + 1 - page.getFromIndex();
	        List<LogFile> resultList = new ArrayList<LogFile>(pageSize);
	        for (int i = page.getFromIndex(); i <= page.getToIndex(); i++) {
	        	resultList.add(new LogFile(logFiles[i]));
	        }
	        
	        page.setResultList(resultList);
        }
		
		return page;
	}
    
    @ResponseBody
    @RequestMapping(value="/{hash}/remove", method=RequestMethod.DELETE)
    public Object remove(@PathVariable int hash, HttpServletResponse response) {
    	 File logFile = doGetLogFile(hash);
    	 if (logFile == null) {
    		 return error("要删除的日志不存在！");
    	 } else if (logFile.isDirectory()) {
    		 deleteDir(logFile, true);
    	 } else {
    		 if (!logFile.delete()) {
    			 return error("删除日志文件失败！");
    		 }
    	 }
    	 return success();
    }

    @ResponseBody
    @RequestMapping(value="/{hash}/clear", method=RequestMethod.PUT)
    public Object clear(@PathVariable int hash, HttpServletResponse response) {
    	 File logFile = doGetLogFile(hash);
    	 if (logFile == null) {
    		 return error("要清空的日志不存在！");
    	 } else if (logFile.isDirectory()) {
    		 deleteDir(logFile, false);
    	 } else {
    		 OutputStream output = null;
    		 try {
    			 output = new FileOutputStream(logFile);
    			 CopyUtil.copy(ArrayUtil.EMPTY_BYTE_ARRAY, output);
    		 } catch (FileNotFoundException e) {
    			 logger.error("要清空的日志不存在：{0}", e, logFile.getAbsoluteFile());
    			 return error("要清空的日志不存在！");
    		 } catch (IOException e) {
    			 logger.error("清空日志异常：{0}", e, logFile.getAbsoluteFile());
    			 return error("清空日志异常！");
    		 } finally {
    			 try {
    				 if (output != null) {
    					 output.close();
    				 }
    			 } catch (IOException e) {
    				 logger.error("关闭已清空的日志异常：{0}", e, logFile.getAbsoluteFile());
    				 return error("关闭已清空的日志异常！");
    			 }
    		 }
    	 }
    	 return success();
    }
    
    @RequestMapping(value="/{hash}/download", method=RequestMethod.GET)
    public void download(@PathVariable int hash, HttpServletResponse response) {
        File logFile = doGetLogFile(hash);
        if (logFile == null || logFile.isDirectory()) {
        	return;
        }
        
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment;fileName=" + logFile.getName());
        
        InputStream input = null;
        try {
            input = new FileInputStream(logFile);
            CopyUtil.copy(input, response.getOutputStream());
        } catch (FileNotFoundException e) {
            throw new NotFoundException("Log file is not exist: " + logFile.getAbsolutePath());
        } catch (IOException e) {
            throw new SystemException("Read log file error: " + logFile.getAbsolutePath());
        } finally {
            try {
                if (input != null) {
                    input.close();
                }
            } catch (IOException e) {
                throw new SystemException("Close log file error: " + logFile.getAbsolutePath());
            }
        }
    }
    
    @RequestMapping(value="/{hash}/monitor", method=RequestMethod.GET)
    public String monitor(@PathVariable int hash, String pos, ModelMap modelMap) {
    	File logFile = doGetLogFile(hash);
    	System.err.println(logFile.getAbsolutePath());
    	if (logFile == null || logFile.isDirectory()) {
    		return null;
    	}
    	
    	long p = 0;
    	if (pos != null) {
	    	try {
	    		p = Long.parseLong(pos);
	    	} catch (NumberFormatException e) {
	    		logger.warn("parameter pos is error: {0}", e, pos);
	    	}
    	}
    	
    	long l = logFile.length();
    	if (p == 0) {
    		p =  l > BATCH_SIZE ? l - BATCH_SIZE : 0;    		
    	} else {
    		p = p < 0 ? p : -p;
    		p += logFile.length();
    		p = p < 0 ? 0 : p;
    	}
    	
        modelMap.put("hash", hash);
        modelMap.put("pos", p);
        return "log/monitor";
    }
    
    @ResponseBody
    @RequestMapping(value = "/{hash}/monitor/{pos}", method = RequestMethod.POST)
    public String getLog(@PathVariable int hash, @PathVariable long pos) {
        File logFile = doGetLogFile(hash);
        if (logFile == null || logFile.isDirectory()) {
        	return null;
        }
        
        String line = null;
        RandomAccessFile randomFile = null;
        StringBuilder response = new StringBuilder();
        try {
            randomFile = new RandomAccessFile(logFile, "r");
            randomFile.seek(pos);
            
            while (response.length() < BATCH_SIZE && (line = randomFile.readLine()) != null) {
                response.append(line + "<br/>");
            }

            return response.length() == 0 ? null : response.toString();
        } catch (FileNotFoundException e) {
            throw new NotFoundException("Log file is not exist: " + logFile.getAbsolutePath());
        } catch (IOException e) {
            throw new SystemException("Read log file error: " + logFile.getAbsolutePath());
        } finally {
            try {
                randomFile.close();
            } catch (IOException e) {
                throw new SystemException("Close log file error: " + logFile.getAbsolutePath());
            }
        }
    }
    
    /* ---- private methods ---- */
    private void deleteDir(File dir, boolean deleteDir) {
    	File[] childs = dir.listFiles();
    	if (childs != null && childs.length > 0) {
    		for (File child : childs) {
    			if (child.isFile()) {
    				child.delete();
    			} else {
    				deleteDir(child, deleteDir);
    			}
    		}
    	}
    	if (deleteDir) {
    		dir.delete();
    	}
    }
    private File doGetLogDir() {
    	return new File(getSystemPropertyLoader().getLogHome());
    }
    
    private File doGetLogFile(int hash) {
		return hashForLogFile(doGetLogDir(), hash);
    }
    
    private File hashForLogFile(File dir, int hash) {
    	File[] files = dir.listFiles();
		for (File file : files) {
			if (file.getAbsolutePath().hashCode() == hash) {
				return file;
			} else if (file.isDirectory()) {
				File child = hashForLogFile(file, hash);
				if (child != null) {
					return child;
				}
			}
		}
		return null;
	}

	/* ---- inner classes ---- */
    public static class LogFile {
    	
    	private String 	name;
    	private String 	size;
    	private boolean directory;
    	private String 	absolutePath;
    	private Date   	lastModifiedTime;
    	private List<LogFile> children;
    	
    	public static final long KB = 1024L;
    	
    	public LogFile(File logFile) {
    		this.name = logFile.getName();
    		this.directory = logFile.isDirectory();
    		this.size = getFileSize(logFile);
    		this.absolutePath = logFile.getAbsolutePath();
    		this.lastModifiedTime = new Date(logFile.lastModified());
    		this.children = getChildrenFiles(logFile);
		}
    	
    	private String getFileSize(File logFile) {
    		return logFile.isDirectory() ? null :
    			(logFile.length() % KB == 0 
    				? logFile.length() / KB 
    				: logFile.length() / KB + 1) + "KB";
		}

    	public int getHash() {
			return getAbsolutePath().hashCode();
		}
    	public String getState() {
    		return isDirectory() ? "closed" : null;
    	}
    	
		public String getName() {
			return this.name;
		}
    	public String getSize() {
    		return this.size;
    	}
    	public boolean isDirectory() {
			return directory;
		}
    	public String getAbsolutePath() {
			return this.absolutePath;
		}
    	public Date getLastModifiedTime() {
			return this.lastModifiedTime;
		}
    	public List<LogFile> getChildren() {
			return children;
		}
    	
    	private List<LogFile> getChildrenFiles(File file) {
    		if (file == null || !file.isDirectory()) {
    			return Collections.emptyList();
    		}
    		
    		File[] childFiles = file.listFiles();
    		if (childFiles == null || childFiles.length == 0) {
    			return Collections.emptyList();
    		}
    		
    		List<LogFile> childList = new ArrayList<LogFile>(childFiles.length);
			for (File child : childFiles) {
				childList.add(new LogFile(child));
			}
			return childList;
    	}
    }
 
}