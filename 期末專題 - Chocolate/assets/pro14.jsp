<!DOCTYPE html>
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>黑金 Chocolate</title>
    <style>
        @import "../assets/css/index.css";
        @import "../assets/css/introduction_pdt.css";
    </style>
    <script src="../assets/js/introduction_pdt.js"></script>
</head>

<body>
    <!----置頂內容---->
    <header>
        <div id="top">
            <a href="../index.html" style="text-decoration: none" class="Chocolate">黑金 Chocolate</a>
        </div>
    </header>

    <main>
        <!----上方菜單---->
        <div class="menu">
            <ul>
                <li class="menu1">
                    <div class="dropdown">
                        <button class="dropbtn">商品分類</button>
                        <div class="dropdown-content">
                            <a href="allproduction.html#top">全部商品</a>
                            <a href="allproduction.html#alcohol">大人口味<br>(含酒)</a>
                            <a href="allproduction.html#childhood">童年回憶</a>
                            <a href="allproduction.html#festival">節慶活動<br>(送禮)</a>
                            <a href="allproduction.html#adult">成長滋味<br>(%數較高)</a>
                        </div>
                    </div>
                </li>
                <li class="menu1">
                    <div class="dropdown">
                        <button class="dropbtn">常見問題</button>
                        <div class="dropdown-content">
                            <a href="">Q&A</a>
                            <a href="">如何挑選</a>
                        </div>
                    </div>
                </li>
                <li class="menu1"> <a href="member.html" style="text-decoration: none" class="menubtn">認識我們</a>

                </li>
                <li class="menu1">
                    <a href="client.html" style="text-decoration: none;" class="menubtn">會員專區</a>
                </li>
                <li class="menu1">
                    <a href="login.html" style="text-decoration: none" class="menubtn">會員登錄/註冊</a>
                </li>
            </ul>
        </div>

        <!----------搜尋框--------->
        <div class="sbox">
            <div class="searchbox">
                <span class="icon"><a href=""><img src="../assets/images/搜尋.png"></a></span>
                <input type="search" id="search" placeholder="Search..." />
            </div>
        </div>

        <!----購物車置底按鈕---->
        <aside>
            <a href="shoppingcar.jsp">
                <img src="../assets/images/購物車1.jpg" class="shoppingcar">
            </a>
        </aside>
        
        <!----商品內頁---->
        <div class="introduction">
            <ul class="list">
                <li class="product_pt">
					<%
					sql = "SELECT `id`,`name`,`img`,`content`,`price`,`figure`FROM `product` WHERE `id`='14'" ;
					ResultSet tmp =  con.createStatement().executeQuery(sql);                 
					while(tmp.next())
					{			
						out.println("<img src='../assets/images/"+tmp.getString(3)+"'alt='產品圖'>");
						out.println("</li><li class='product_text'><p class='product_ititle'>"+tmp.getString(2)+"</p>");
						out.println("<p class='product_itd'>★成分:<br/>"+tmp.getString(4)+"<br/>");
						out.println("★商品特色★<br />"+tmp.getString(6)+"<br />");
						out.println("★價錢:"+tmp.getString(5)+"<br />");
						out.println("<p>訂購數量:</p><input min='1' type='number' name='quantity' value='1' class='car_button'>");
					session.setAttribute("id",tmp.getString(1));
					
					}
					
					%>
					 <!----直接加入購物車按鈕---->
                    <input type="button" value="加入購物車" onclick="location.href='addshoppingcar.jsp';"
                        class="gotoshoppingcar">
                 <!--  <input type="button" value="直接購買" onclick="location.href='pay.html';" class="gotoshoppingcar">--> 
                </li>
            </ul>
            <!----星等級評價---->
            <ul class="star_comment">
                <li class="product_starlevel">
                    <div class="stars">
						<form action="addboard.jsp" class="star_commentbox">
								<p class="startitle"><b>評價：</b></p>
								<div class="rating">
									<input type="radio" name="star" id="star1">
									<label for="star1"></label>
									<input type="radio" name="star" id="star2">
									<label for="star2"></label>
									<input type="radio" name="star" id="star3">
									<label for="star3"></label>
									<input type="radio" name="star" id="star4">
									<label for="star4"></label>
									<input type="radio" name="star" id="star5">
									<label for="star5"></label>
								</div>	
                        <input type="text" placeholder="寫下評價 Write down your comments" name="mcontent" required><br/>
                        <input type="submit" value="送出評價" class="sendto">
						</form>
                    </div>
                </li>
            </ul>
            <!----其他買家評價---->
            <ul class="buyer_comment">
                <div class="allcomments">
                    <p class="allcommentstitle">其他買家評價</p>
                    <%  

           sql="SELECT * FROM `board`";
           ResultSet rs=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
           rs.last();
           int total_content=rs.getRow();
           //out.println("共"+total_content+"筆留言<p>");
           int page_num=(int)Math.ceil((double)total_content/5.0);
           //out.println("請選擇頁數");
           //for(int i=1;i<=page_num;i++)
			//   out.print("<a href='view.jsp?page="+i+"'>"+i+"</a>&nbsp;");
           //out.println("<p>");
           
           String page_string = request.getParameter("page");
           if (page_string == null) 
               page_string = "0";          
           int current_page=Integer.valueOf(page_string);
           if(current_page==0) 
	          current_page=1;
           int start_record=(current_page-1)*5;
           sql="SELECT * FROM `board` WHERE `proname`='明治 代可可脂黑巧克力' ORDER BY `boid` DESC LIMIT ";
           sql+=start_record+",5";

							// current_page... SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT
							//      current_page=1: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 0, 5
							//      current_page=2: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 5, 5
							//      current_page=3: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 10, 5
           rs=con.createStatement().executeQuery(sql);
           while(rs.next())
                {
				out.println("<div class='comments_container'>");
				out.println("<p class='comments_stars'>★★★★</p>");
				out.println("<p class='comments_content'>"+rs.getString(3)+"</p>");
				out.println("</div>");
				}  %>  
                </div>
            </ul>
        </div>
    </main>

    <!----置底內容---->
    <footer>
        <p>♥ 版權皆為黑金團隊所有 ♥</p>
    </footer>

</body>

</html>