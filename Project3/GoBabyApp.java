import java.io.*;
import java.util.*;
import java.sql.* ;
import java.text.*;



public class GoBabyApp {   
    
    public static Connection connectDB() throws SQLException{

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!

        String your_userid = "";
        String your_password = "";

        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd 
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;

        return con;
    }

    public static String loginApp(Scanner scanner, Connection con, Statement statement, int sqlCode, String sqlState) throws SQLException {

        while (true) {
            try{
                // start up 
                System.out.print("Please enter your practitioner id ([E] to exit): ");
                String in_id = scanner.nextLine();

                // System.out.println(in_id);

                if(in_id.equals("E")){ exitAPP(scanner, con, statement); }
                
                if(in_id.length() != 14 || !in_id.substring(0,3).equals("MW ")){
                    // System.out.print("pos in - ");
                    System.out.println("INVALID Practitioner id.");
                    continue;
                }

                String querySQL = "SELECT pID, name FROM Midwife WHERE pID = \'"+ in_id + "\'";
                java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;
                String pID = null;

                while ( rs.next() ){
                    // System.out.println ("loading...");
                    pID = rs.getString(1);
                    // String name = rs.getString(2);

                    // System.out.println ("hello, " + name + " your pid is: " + pID);
                }

                if(pID == null){
                    // System.out.print("pos null - ");
                    System.out.println("INVALID Practitioner id.");
                    continue;
                }

                return pID; 
            }
            catch (SQLException e){
                sqlCode = e.getErrorCode(); // Get SQLCODE
                sqlState = e.getSQLState(); // Get SQLSTATE
                        
                System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                System.out.println(e);
            }
        }
    }

    public static void printAppointment(ArrayList<String[]> queryInfo){

        System.out.println("\n ============ ============ ============ =========== \n");

        for (String[] q : queryInfo){
            System.out.println( q[0] + ":  " + q[1] + "\t" + q[2] + "\t" + q[3] + "\t" +  q[4]);
        }
        System.out.println("\n ============ ============ ============ =========== \n");

    }

    public static void exitAPP (Scanner scanner, Connection con, Statement statement) throws SQLException {

        scanner.close();
        statement.close();
        con.close();

        System.out.println("==============     EXIT     =================");
        System.exit(0);
        System.out.print("yah?");
    }

    public static ArrayList<String[]> queryAppointments(String log_Midwife_id, Scanner scanner, Connection con, Statement statement, int sqlCode, String sqlState) throws SQLException {

        while (true) {
            try{
                // query for appointments
                System.out.print("Please enter the date(YYYY-MM-DD) for appointment list ([E] to exit): ");
                String in_date = scanner.nextLine();

                // System.out.println(in_date);

                if(in_date.equals("E")){ exitAPP(scanner, con, statement); }

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                String date = "";

                try {
                    date = format.format(format.parse(in_date));

                } catch(ParseException e) {
                    System.out.println("INVALID date.");
                    continue; 
                }

                System.out.println("\nqureying appointment for " + log_Midwife_id + " on " + date);

                String querySQL =  "with astbl(pcID, pID, atype) as ("
                               + "Select AssignPrimary.pcID, AssignPrimary.pID, COALESCE('P','P') FROM AssignPrimary "
                               + "union "
                               + "Select AssignBackup.pcID, AssignBackup.pID, COALESCE('B','B') FROM AssignBackup) "
                               + "SELECT time(Appointment.DateAndTime) as time, astbl.atype, Mother.name, Mother.qhcID, Appointment.aID, astbl.pcID  "
                               + "FROM SetupAppointment s, Appointment, astbl, isPregnant, AsMother, Mother "
                               + "WHERE s.aID = Appointment.aID AND Appointment.DateAndTime >= TIMESTAMP\'" + date + "-00.00.00.000000\' "
                               + "AND Appointment.DateAndTime <= TIMESTAMP\'" + date + "-23.59.59.000000\' "
                               + "AND s.pID = astbl.pID AND s.pcID = astbl.pcID AND s.pID = \'" + log_Midwife_id + "\' "
                               + "AND s.pcID = isPregnant.pcID AND isPregnant.cID = AsMother.cID AND AsMother.qhcID = Mother.qhcID ORDER BY time" ;
                        
        
                java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

                // System.out.println ("\nloading...");

                // String [] queryInfo;

                ArrayList< String[]> queryInfo = new ArrayList< String[]>();

                // String pID = null;
                int i = 1;
                while ( rs.next() ){
                
                    String time = rs.getString(1);
                    String type = rs.getString(2);
                    String motherName = rs.getString(3);
                    String qhcid = rs.getString(4);
                    String aID = rs.getString(5);
                    String pcID = rs.getString(6);

                    String[] ainfo = {Integer.toString(rs.getRow()), time, type, motherName, qhcid, aID, pcID};
                    queryInfo.add(ainfo);
                    i++;
                }

                if(i == 1){
                    System.out.println("\nPractitioner id: " + log_Midwife_id + ", you have no appointment on " + date + "\n");
                    continue;
                }

                // printAppointment(queryInfo);


                return queryInfo;
            }
            catch (SQLException e){
                sqlCode = e.getErrorCode(); // Get SQLCODE
                sqlState = e.getSQLState(); // Get SQLSTATE
                        
                System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                System.out.println(e);
            }
        }
    }

    public static void main(String[] args) throws SQLException{


        System.out.println("hello there~ \n ==========  Welcome to GoBaby  ==============");

        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        Connection con = connectDB();
        Statement statement = con.createStatement ( ) ;

        Scanner scanner = new Scanner(System.in);

        String log_Midwife_id = loginApp(scanner, con, statement, sqlCode, sqlState);

        System.out.println("\nHello, " + log_Midwife_id + "\n");

        ArrayList< String[]> queryInfo = queryAppointments(log_Midwife_id, scanner, con, statement, sqlCode, sqlState);
        
        printAppointment(queryInfo);

        while (true){


            System.out.print("Enter the appointment number that you would like to work on.\n"
                                + "[E] to exit [D] to go back to another date : ");

            String ind = scanner.nextLine();

            // System.out.println(ind);

            if(ind.equals("E")){ exitAPP(scanner, con, statement); }

            if(ind.equals("D")){ 
                queryInfo = queryAppointments(log_Midwife_id, scanner, con, statement, sqlCode, sqlState);
                printAppointment(queryInfo);
                continue; 
            }

            int app_ind = -1;

            try{
                app_ind = Integer.parseInt(ind);
            }
            catch(NumberFormatException e){

                System.out.println("INVALID appointment number.");
                continue; 
            }

            if(app_ind<=0 || app_ind > queryInfo.size()){

                System.out.println("INVALID appointment number.");
                continue; 
            }

            // System.out.println(queryInfo.get(app_ind-1));
            String[] currinfo = queryInfo.get(app_ind-1);

            while(true){
                System.out.println("\n ================ ================ ===============\n");

                System.out.println("For " + currinfo[3] + "    " + currinfo[4] + "\n");

                System.out.println("1. Review notes\n"
                                + "2. Review tests\n"
                                + "3. Add a note\n"
                                + "4. Prescribe a test\n"
                                + "5. Go back to the appointments.\n");

                System.out.print("Enter your choice: ");

                String choice = scanner.nextLine();
                if (choice .equals("5")){
                    printAppointment(queryInfo);
                    break;
                }

                try{
                    switch (choice){

                        case "1":

                            String querySQL1 = "SELECT date(Note.nTime) as date, time(Note.nTime) as time, Note.content "
                                            + "FROM SetupAppointment s, Appointment, Note "
                                            + "WHERE s.pcID = \'"+ currinfo[6] + "\' "
                                            + "AND Appointment.aID = s.aID AND Appointment.aID = Note.aID "
                                            + "ORDER BY Note.nTime DESC " ;
                            
                            java.sql.ResultSet rs1 = statement.executeQuery ( querySQL1 );

                            String date = "";

                            System.out.println();

                            while ( rs1.next() ){
                                date = rs1.getString(1);
                                String time = rs1.getString(2);
                                String content = rs1.getString(3);

                                System.out.println (date + "   " + time + "   " + content);
                            }

                            if (date.equals("")){
                                System.out.println ("There is no note yet :) ");
                            }

                            break;
                        case "2":

                            String querySQL2 = "SELECT date(MedicalTest.prescribedDate) as date, MedicalTest.testType, COALESCE(MedicalTest.result, 'PENDING') as result "
                                            + "FROM SetupAppointment s, Prescribtion, MedicalTest "
                                            + "WHERE s.pcID = \'"+ currinfo[6] + "\' "
                                            + "AND Prescribtion.aID = s.aID AND Prescribtion.tID = MedicalTest.tID ORDER BY MedicalTest.prescribedDate DESC";

                            java.sql.ResultSet rs2 = statement.executeQuery ( querySQL2 );

                            date = "";

                            System.out.println();

                            while ( rs2.next() ){
                                date = rs2.getString(1);
                                String type = rs2.getString(2);
                                String result = rs2.getString(3);

                                System.out.println (date + "   [" + type + "]   " + result);
                            }

                            if (date.equals("")){
                                System.out.println ("There is no medical test being prescriped yet :) ");
                            }

                            break;
                        case "3":
                            System.out.print("Please type your observation: ");
                            String observation = scanner.nextLine();

                            String insertSQL3 = "INSERT INTO Note (aID, nTime, content) "
                                            + "VALUES(\'" + currinfo[5] + "\', CURRENT_TIMESTAMP, \'" + observation + "\') ";
                            statement.executeUpdate ( insertSQL3 ) ;

                            break;
                        case "4":
                            System.out.print("Please enter the type of test: ");
                            String ttype = scanner.nextLine();
                            String testtype = ttype.substring(0, 1).toUpperCase() + ttype.substring(1);

                            String countquery = "SELECT count(*) FROM MedicalTest WHERE testType = \'" + testtype + "\'";
                            // System.out.print(countquery);
                            java.sql.ResultSet rs4 = statement.executeQuery ( countquery );
                            rs4.next();
                            int count = rs4.getInt(1);
                            // System.out.println(count);
                            String num = "00"+Integer.toString(count+1);

                            String testID = "T-" + testtype.substring(0, 1) + " N " + num.substring(num.length()-3);

                            String insertSQL_prescribtion = " INSERT INTO Prescribtion (aID,tID) " 
                                                        + "VALUES(\'" + currinfo[5] + "\', \'" + testID + "\') ";

                            String insertSQL4 = "INSERT INTO MedicalTest (tID, testType, prescribedDate) "
                                            + "VALUES(\'" + testID + "\', \'" + testtype + "\' ,CURRENT_TIMESTAMP) ";

                            // System.out.print(insertSQL4);
                            statement.executeUpdate ( insertSQL4 ) ;
                            statement.executeUpdate ( insertSQL_prescribtion ) ;

                            break;
                
                    }


                }
                catch (SQLException e){
                    sqlCode = e.getErrorCode(); // Get SQLCODE
                    sqlState = e.getSQLState(); // Get SQLSTATE
                            
                    System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                    System.out.println(e);
                }
            }
            // System.out.println(app_ind);
            // if(!ind.isDigit()){
            // }
            // System.out.println(queryInfo.get(index));
            // break;
        }
        // statement.close();
        // con.close();
    }

}
















