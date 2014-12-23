
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
    function ShowArticleMessage(id)
    {
        if((document.getElementById(id).style.display == 'inline'))
        {
            document.getElementById(id).style.display='none';
        }else if((document.getElementById(id).style.display == 'none'))
        {
            document.getElementById(id).style.display='inline';
        }
    }
</script>

<link rel="stylesheet" type="text/css" href="yui/menu.css" />
<link rel="stylesheet" type="text/css" href="yui/button.css" />
<link rel="stylesheet" type="text/css" href="yui/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="yui/container.css" />
<link rel="stylesheet" type="text/css" href="yui/editor.css" />
<script type="text/javascript" src="yui/yahoo-dom-event.js"></script>

<script type="text/javascript" src="yui/element-beta-min.js"></script>
<script type="text/javascript" src="yui/container-min.js"></script>
<script type="text/javascript" src="yui/menu-min.js"></script>
<script type="text/javascript" src="yui/button-min.js"></script>
<script type="text/javascript" src="yui/editor-min.js"></script>

<!--there is no custom header content for this example-->


<div style="clear:both;width:720px;height:5px;"> </div>
<div class="pt"><div class="pb"><div class="pl"><div class="pr"><div class="pbl"><div class="pbr"><div class="ptl"><div class="ptr">

                                <div style="width:720px;" ><table><td>

                                            <c:if test="${articles == null  }" >
                                                <div  style="float:left;width:720px;height:15px;"></div>
                                                <span style="padding-left:100px"> <a href="article.do" title="Post an article!" class="lhb">Article Posting</a></span>
                                                <span style="padding-left:175px" ><a href="myArticles.do" title="List of articles posted by you"><span  class="fv12bl" >My Articles</span></a></span>
                                                <div  style="float:left;width:720px;height:20px;"></div>
                                            </c:if>

                                            <c:if test="${articles != null  }" >
                                                <div  style="float:left;width:720px;height:15px;"></div>
                                                <span  style="padding-left:100px"><a  href="article.do" title="Post an article!" class="fv12bl">Article Posting</a></span>
                                                <span style="padding-left:175px" ><a href="myArticles.do" title="List of articles posted by you"><span  class="lhb" >My Articles</span></a></span>
                                                <div  style="float:left;width:720px;height:20px;"></div>
                                            </c:if>

                                            <c:if test="${articles == null  }" >


                                                <% if(request.getAttribute("output")!= null) { %>
                                                <div style="float:left;width:720px;height:10px;"></div>
                                                <div class="fv12bc" style="float:left;width:720px;height:20px;padding-left:12px;color:#F358A2;">
                                                    <%= request.getAttribute("output") %>
                                                </div>
                                                <div style="float:left;width:720px;height:10px;"></div>

                                                <% } %>
                                                <div  style="float:left;width:720px;height:15px;"></div>

                                            <body class="yui-skin-sam">

                                                <div style="padding:0 0 0 50px">
                                                    <form name ="form1" method="post" action="articlePosting.do"  id="form1">
                                                        <div style="display:none"> <input type="text" name="article"></div>

                                                        Enter title of the Article :  <input style="width:450px;" type="text" name="title" />
                                                        <br /> <br />
                                                        <a  id="editor" name="editor" tiltle="Enter your message!" ></a>

                                                        <br />

                                                        <input  type="image" style="margin:0 0 0 280px;display:inline"  src="bbsimages/buttons/PostArticle.png" onmouseover="sbmt()" />


                                                    </form>

                                                </div>
                                                <div style="float:left;width:720px;height:10px;"></div>

                                            </c:if>


                                            <% int c=1; %>
                                            <c:if test="${articles != null  }" >
                                                <div class="fvl2b"  style="float:left;width:720px;"></div>
                                                <c:forEach items="${articles}" var="article">

                                                    <div id="bg<c:out value="${article.uuid}" />" class="fv14bc" onmouseover="this.style.backgroundColor='#A6ACA0'" onmouseout="this.style.backgroundColor='#DBD9DA'"  style="float:left;width:680px;background-color:#DBD9DA;padding-left:20px;"><%= c %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a title="Article content" href="javascript:return false;" onclick="ShowArticleMessage('<c:out value="${article.uuid}" />');event.returnValue=false;return false;" ><c:out value="${article.title}" /></a></div>

                                                    <div style="float:left;width:720px;height:10px;"></div>

                                                    <div class="fv11"  id="<c:out value="${article.uuid}" />" style="float:left;width:660px;display:none;padding-left:20px;padding-right:20px;" >



                                                        <c:out value='${article.message}' escapeXml="false" />

                                                        <div style="float:left;width:720px;height:5px;"></div>
                                                    </div>

                                                    <% c++; %>
                                                </c:forEach>
                                                <div  style="float:left;width:720px;height:10px;"></div>

                                            </c:if>




                                        </td></table>
                                </div>

                            </div></div></div></div></div></div></div></div>
<div style="clear:both"> </div>
<script>





    var myEditor;
    function sbmt(){
        //  alert("tttt"+myEditor.saveHTML());
        document.form1.article.value = myEditor.saveHTML();
    }
    (function() {
        var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event;

        var myConfig = {
            height: '300px',
            width: '600px',
            dompath: true,
            focusAtStart: true
        };

        YAHOO.log('Create the Editor..', 'info', 'example');
        myEditor = new YAHOO.widget.Editor('editor', myConfig);
        myEditor._defaultToolbar.buttonType = 'advanced';
        myEditor.render();

    })();

    <!--YAHOO.util.Event.on('form1','submit',function(e){myEditor.saveHTML();});-->
</script>
