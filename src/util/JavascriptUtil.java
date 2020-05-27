package util;

import javax.servlet.jsp.JspWriter;

public class JavascriptUtil {
	
	public static String jsAlertLocation(String msg, String url) {		
		String str = ""
				+ "<script>"
				+ "  alert('"+msg+"');  "
				+ "  location.href='"+url+"';  "
				+ "</script>";
		return str;
	}
	public static String jsAlertBack(String msg) {
		
		String str = ""
				+ "<script>"
				+ "  alert('"+msg+"');  "
				+ "  history.back(); "
				+ "</script>";
		return str;
	}	
	
	public static void jsAlertLocation(String msg,
			String url, JspWriter out) {
		try {
			String str = ""
					+ "<script>"
					+ "  alert('"+msg+"');  "
					+ "  location.href='"+url+"';  "
					+ "</script>";
			out.println(str);
		}
		catch(Exception e) {}
	}

	public static void jsAlertBack(String msg, JspWriter out) {
		try {
			String str = ""
					+ "<script>"
					+ "  alert('"+msg+"');  "
					+ "  history.back(); "
					+ "</script>";
			out.println(str);
		}
		catch(Exception e) {}
	}
}
