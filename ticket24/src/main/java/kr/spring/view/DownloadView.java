package kr.spring.view;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class DownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		byte[] file = (byte[])model.get("downloadFile");
		String filename = (String)model.get("filename");
		filename = removePrefix(filename, "_");
		
		response.setContentType("application/download; charset=utf-8");
		response.setContentLength(file.length);
		
		String fileName = new String(
				filename.getBytes("utf-8"),"iso-8859-1");	
		
		response.setHeader("Content-Disposition", 
				"attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		InputStream input = null;
		try {
			input = new ByteArrayInputStream(file);
			IOUtils.copy(input, out);
			out.flush();
		}finally {
			if(out!=null) out.close();
			if(input!=null) input.close();
		}
	}
	//앞의 난수 없애기
	public static String removePrefix(String originalFileName, String delimiter) {
        int index = originalFileName.indexOf(delimiter);
        if (index != -1) {
            // "_" 다음의 문자열을 가져옴
            return originalFileName.substring(index + 1);
        } else {
            // "_"이 없을 경우 원래 파일 이름 반환
            return originalFileName;
        }
    }

}





