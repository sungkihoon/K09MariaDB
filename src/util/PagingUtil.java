package util;

public class PagingUtil {
   
   public static String pagingImg(int totalRecordCount,
         int pageSize, int blockPage, int nowPage, String pageName) {
      String pagingStr = "";
      
      int totalPage = 
            (int)(Math.ceil(((double)totalRecordCount/pageSize)));
      
      int intTemp = (((nowPage-1) /blockPage)* blockPage +1);
      
      if(intTemp !=1 ) {
         pagingStr += ""
            +"<a href='"+pageName+"nowPage=1'>"
            +"<img src='../images/paging1.gif'></a>";
         pagingStr += "&nbsp;";
         pagingStr += ""
            +"<a href='"+pageName+"nowPage="+
                     (intTemp-blockPage)+"'>"
            +"<img src='../images/paging2.gif'></a>";
      }
      
      int blockCount =1;
      while(blockCount<=blockPage && intTemp<=totalPage)
      {
         if(intTemp==nowPage) {
            pagingStr += "&nbsp;"+intTemp+"&nbsp;";
         }
         else {
            pagingStr += "&nbsp;<a href='"+pageName
                  +"nowPage="+intTemp+"'>"+
                  intTemp+"</a>&nbsp;";
         }
         intTemp++;
         blockCount++;
      }
      
      if(intTemp<= totalPage) {
         pagingStr += "<a href='"+pageName+"nowPage="+
                                 intTemp+"'>"
            +"<img src='../images/paging3.gif'></a>";
         pagingStr += "&nbsp;";
         pagingStr += "<a href='"+pageName+"nowPage="+
                              totalPage+"'>"
            +"<img src='../images/paging4.gif'></a>";
      }
      return pagingStr;
   }

	
   public static String pagingBS4(int totalRecordCount,
	         int pageSize, int blockPage, int nowPage, String pageName) {
	      
	      String pagingStr = "";

	      int totalPage =   (int)(Math.ceil(((double)totalRecordCount/pageSize)));
	      //System.out.println(totalPage);
	      
	      int intTemp = (((nowPage-1) / blockPage) * blockPage) + 1;
	      //System.out.println(intTemp);
	      
	      if(intTemp != 1) {
	         //첫페이지로
	         pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage=1' class='page-link'><i class='fas fa-angle-double-left'></i></a></li>";
	         //이전블록으로
	         pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+(intTemp-1)+"' class='page-link'><i class='fas fa-angle-left'></i></a></li>";
	      }

	      int blockCount = 1;
	      while(blockCount<=blockPage && intTemp<=totalPage)
	      {
	         //페이지 바로가기
	         if(intTemp==nowPage) {
	            //현재페이지인경우
	            pagingStr += "<li class='page-item active'><a href='#' class='page-link'>"+intTemp+"</a></li>";
	         }
	         else {
	            //현재페이지가 아닌경우
	            pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+intTemp+"' class='page-link'>"+intTemp+"</a></li>";
	         }
	         intTemp++;
	         blockCount++;
	      }

	      if(intTemp <= totalPage) {
	         //다음 페이지 블록으로
	         pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+intTemp+"' class='page-link'><i class='fas fa-angle-right'></i></a></li>";
	         
	         //마지막 페이지로..
	         pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+totalPage+"' class='page-link'><i class='fas fa-angle-double-right'></i></a></li>";
	      }

	      return pagingStr;
	   }
	
}



















