
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.Date"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ include file="../Admin/AdminMainPage.jsp" %>
<%!
    public void callingEmails(String emailSend, String subjectCode, String subjectName, String startDateInput, 
            String endDateInput, String venueInput, String objectiveInput, String courseCategoryInput, String durationInput, 
            String organizerInput, String courseStatusInput, String staffNumberInput, String courseTutorInput ) {
        
        
        //Creating a result for getting status that messsage is delivered or not!
        String result;

        // Get recipient's email-ID, message & subject-line from index.html page
        final String to = emailSend;
        final String subject;
        final String messg;

        // Sender's email ID and password needs to be mentioned
        final String from = "handstosyria@gmail.com";
        final String pass = "20UTMstudents";

        // Defining the gmail host
        String host = "smtp.gmail.com";

        // Creating Properties object
        Properties props = new Properties();

        // Defining properties
        props.put("mail.smtp.host", host);
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.user", from);
        props.put("mail.password", pass);
        props.put("mail.port", "465");

        // Authorized the Session object.
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        });

        try {

            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));

            // Set Subject: header field
            message.setSubject("New Course created " + subjectName );
            
         // Now set the actual message
            //message.setText("Thank You For Register " + "\nThis Is Your Registration Information" + "\nName : " + fname + " " + lname + "\nPassword : " + pwd + "\nEmail : " + to + "\nStatus : " + status);
            String template= "Course Code="+ subjectCode +",\nCourse Name="+ subjectName +",\n"
                    + "Start Date="+ startDateInput +",\nEnd Date="+ endDateInput +",\nVenue="+ venueInput +",\nObjectives="+ objectiveInput +",\n"
                    + "Category="+ courseCategoryInput +",\nDuration=0"+ durationInput +":00:00,\nOrganizer="+ organizerInput +",\n"
                    + "Course Status="+ courseStatusInput +",\nStaff Involve="+ staffNumberInput +",\nCourse Tutor="+ courseTutorInput;
            message.setText(template);

            // Send message
            Transport.send(message);
            result = "Your mail sent successfully....";
        } catch (MessagingException mex) {
            mex.printStackTrace();
            result = "Error: unable to send mail....";
        }
    }
%>

            <li><a href="manageCourse.jsp" class="list-group-item-info"><i class="glyphicon glyphicon-hand-right"></i> Manage Course</a></li>
            <li><a href="generateCertificate.jsp"><i class="glyphicon glyphicon-pencil"></i> Generate Certificate</a></li>
            <li><a href="generateReport.jsp"><i class="glyphicon glyphicon-cloud"></i> Generate Report</a></li>
            <li><a href="editProfile.jsp"><i class="glyphicon glyphicon-leaf"></i> Edit Profile</a></li>
            <li><a href="../logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Log Out</a></li>
            </ul>
            </div>
        </div>
    </nav>

    <%
            ResultSet resultSet;
            String getCourseIDtoUpdate = request.getParameter("getCourseIDtoUpdate");
            boolean updateButtonCourse = false;
            String  courseCodeInput = null,
                    courseNameInput = null,
                    courseTutorInput = null,
                    venueInput = null,
                    objectiveInput = null,
                    organizerInput = null,
                    courseCategoryInput = null,
                    startDateInput = null,
                    endDateInput = null,
                    courseStatusInput = null,
                    staffNumberInput = null,
                    durationInput = null,
                    template = null,
                    temp = null,
                    KJsapa = null,
                    emailNeedToSend = null,
                    temp1 = null;
            int count = 1;
            Date startDate = new Date(0);
            Date endDate = new Date(0);
            
            template = "SELECT * FROM courseinfo WHERE courseID='" + getCourseIDtoUpdate + "'";
            resultSet = DBConnect.doQuery(template);
            while (resultSet.next()){
                courseCodeInput          = resultSet.getString("courseCode");
                courseNameInput          = resultSet.getString("courseName");
                venueInput               = resultSet.getString("venue");
                objectiveInput           = resultSet.getString("objectives");
                courseCategoryInput      = resultSet.getString("category");
                durationInput            = resultSet.getString("duration");
                organizerInput           = resultSet.getString("organizer");
                courseStatusInput        = resultSet.getString("courseStatus");
                staffNumberInput         = resultSet.getString("staffNum");
                courseTutorInput         = resultSet.getString("courseTutor");
                startDate                = resultSet.getDate("startDate");
                endDate                  = resultSet.getDate("endDate");
                
                DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                startDateInput = df.format(startDate);
                endDateInput = df.format(endDate);
                
                temp1 = courseCodeInput;
            }
        %>
    
    <div id="page-wrapper">
        <!-- UPDATE COURSE -->    
        <div class="targetDiv" id="div2">
            <div class="container">
              <div class="row clearfix">
                  <div class="col-md-8 column">
                      <h3 class="page-header">Update Course "<%= courseNameInput %>"</h3>
                      <form class="form-horizontal" role="myFormUpdate" data-toggle="validator">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Course Code</label>
                            <div class="col-sm-5">
                                <input type="hidden" name="courseIDtoUpdate" value="<%= getCourseIDtoUpdate%>">
                                <input value="<%= courseCodeInput %>" name="courseCodeInput" type="text" pattern="^[a-zA-Z0-9]{6,}$" data-minlength="6" maxlength="10" class="form-control" id="courseCode" data-error="Invalid Course Code" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group"> 
                            <label class="col-sm-2 control-label">Course Name</label>
                            <div class="col-sm-5">
                                <input value="<%= courseNameInput %>" name="courseNameInput" type="text" pattern="^[a-zA-Z0-9 ]{6,}" data-minlength="6" maxlength="30" class="form-control" id="courseCode" data-error="Invalid Course Name" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">Course Tutor</label>
                            <div class="col-sm-5">
                                <input value="<%= courseTutorInput %>" name="courseTutorInput" type="text" pattern="^[a-zA-Z. ]{6,}" data-minlength="6" maxlength="25" class="form-control" id="courseCode" data-error="Invalid Course Tutor" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Venue</label>
                            <div class="col-sm-5">
                                <input value="<%= venueInput %>" name="venueInput" type="text" pattern="^[a-zA-Z0-9.() ]{4,}" data-minlength="4" maxlength="30" class="form-control" id="courseCode" data-error="Invalid Venue" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Objective</label>
                            <div class="col-sm-5">
                                <input value="<%= objectiveInput %>" name="objectiveInput" type="text" pattern="^[a-zA-Z0-9.() ]{4,}" data-minlength="4" maxlength="30" class="form-control" id="courseCode" data-error="Invalid Objective" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Organizer</label>
                            <div class="col-sm-5">
                                <input value="<%= organizerInput %>" name="organizerInput" type="text" pattern="^[a-zA-Z0-9.() ]{4,}" data-minlength="4" maxlength="30" class="form-control" id="courseCode" data-error="Invalid Organizer" required/>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Course Category</label>
                            <div class="col-sm-5">
                                <select name="courseCategoryInput" class="form-control">
                                    <option>Academic</option>
                                    <option>Non-academic</option>
                                    <option>Latihan ICT</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Start Date</label>
                            <div class="col-sm-5">
                                <div class="input-append date input-group" id="dp3" data-date=" " data-date-format="dd-mm-yyyy">
                                    <input value="<%= startDateInput %>" name="startDateInput" class="form-control input-sm" value="" type="text" data-required="true"/>
                                        <span class="add-on input-group-addon" style="background:transparent;"><i class="glyphicon glyphicon-calendar text-danger"></i>
                                        </span>
                        </div></div></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">End Date</label>
                            <div class="col-sm-5">
                                <div class="input-append date input-group" id="dp4" data-date=" " data-date-format="dd-mm-yyyy">
                                    <input value="<%= endDateInput %>" name="endDateInput" class="form-control input-sm" value="" type="text" data-required="true"/>
                                        <span class="add-on input-group-addon" style="background:transparent;"><i class="glyphicon glyphicon-calendar text-danger"></i>
                                        </span>
                                </div> </div></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Course Status</label>
                            <div class="col-sm-5">
                                <select name="courseStatusInput" class="form-control">
                                    <option>Done</option>
                                    <option>Plan</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Number of Staff In-Charge</label>
                            <div class="col-sm-5">
                                <select name="staffNumberInput" class="form-control">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                    <option>10</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Duration (hours)</label>
                            <div class="col-sm-5">
                                <select name="durationInput" class="form-control">
                                    <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                        <option>6</option>
                                        <option>7</option>
                                        <option>8</option>
                                        <option>9</option>
                                        <option>10</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Head Of Department</label>
                            <div class="col-sm-5">
                                <select name="KJsapa" class="form-control">
                                    <option>Dr. Dayang Norhayati</option>
                                    <option>Dr. Zulhilmi Ismail</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button name="updateButtonCourse" value="true" type="submit" class="btn btn-primary">Update Course</button>
                            </div>
                        </div>
            </form>
            <%
                updateButtonCourse = Boolean.parseBoolean(request.getParameter("updateButtonCourse"));
                
                if(updateButtonCourse){
                    getCourseIDtoUpdate = request.getParameter("courseIDtoUpdate");
                    courseCodeInput     = request.getParameter("courseCodeInput");
                    courseNameInput     = request.getParameter("courseNameInput");
                    courseTutorInput    = request.getParameter("courseTutorInput");
                    venueInput          = request.getParameter("venueInput");
                    objectiveInput      = request.getParameter("objectiveInput");         
                    organizerInput      = request.getParameter("organizerInput");        
                    courseCategoryInput = request.getParameter("courseCategoryInput");        
                    startDateInput      = request.getParameter("startDateInput");       
                    endDateInput        = request.getParameter("endDateInput");       
                    courseStatusInput   = request.getParameter("courseStatusInput");       
                    staffNumberInput    = request.getParameter("staffNumberInput");       
                    durationInput       = request.getParameter("durationInput");
                    KJsapa              = request.getParameter("KJsapa");
                    
                    String[] parts = startDateInput.split("-", 3);
                    startDateInput = parts[2] + "-" + parts[1] + "-" + parts[0];    //part2(year), part1(month), part0(day)
                    
                    parts = endDateInput.split("-", 3);
                    endDateInput = parts[2] + "-" + parts[1] + "-" + parts[0];      //part2(year), part1(month), part0(day)
                    
                 template = "UPDATE courseinfo SET courseCode='"+ courseCodeInput +"', courseName='"+ courseNameInput +"', "
                    + "startDate='"+ startDateInput +"', endDate='"+ endDateInput +"', venue='"+ venueInput +"', objectives='"+ objectiveInput +"',"
                    + "category='"+ courseCategoryInput +"', duration='0"+ durationInput +":00:00', organizer='"+ organizerInput +"', "
                    + "courseStatus='"+ courseStatusInput +"', staffNum='"+ staffNumberInput +"', courseTutor='"+ courseTutorInput +"' WHERE courseID='" +getCourseIDtoUpdate + "'";
                
                 if(KJsapa.equals("Dr. Dayang Norhayati"))
                    emailNeedToSend = "dayang@utm.my";

                 else if(KJsapa.equals("Dr. Zulhilmi Ismail"))
                    emailNeedToSend = "zulhilmi@utm.my";

                    try{ 
                        stmt.executeUpdate(template);
                        callingEmails(emailNeedToSend, courseCodeInput, courseNameInput, 
                                                    startDateInput, endDateInput, venueInput, objectiveInput, 
                                                    courseCategoryInput, durationInput, organizerInput, courseStatusInput,
                                                    staffNumberInput, courseTutorInput);
                        String myTemp = "updateCourse.jsp?getCourseIDtoUpdate=" + getCourseIDtoUpdate;
                        response.sendRedirect(myTemp); 
                    }
                    catch(SQLException sqle){
                        System.err.println("Error connecting: " + sqle);
                        %><script type="text/javascript">
                            toastr.error("Failed","Somethin When wrong, please inform technician");    
                        </script><%
                    }
                }
            %>      
                  </div></div></div></div>
        </div>
<script src="../js/bootstrap-datepicker.js" type="text/javascript"></script>
<script type="text/javascript">
   $(document).ready(function(){
       $('#dp3').datepicker();
       $('#dp4').datepicker();
   });
</script>            
<script type="text/javascript">
    $('#myFormUpdate').validator();
</script> 
<jsp:include page="footer.jsp"/>