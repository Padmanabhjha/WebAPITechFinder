using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TechFinderWebAPI
{
    public class DataAccessLayer
    {

        public DataSet AccessDatabase(string lat,string longitude, string skill)
        {
            // Create the connection to the resource!
            // This is the connection, that is established and
            // will be available throughout this block.
            //using (SqlConnection conn = new SqlConnection())
            //{
                // Create the connectionString
                // Trusted_Connection is used to denote the connection uses Windows Authentication
                //int noOfRows;
                //conn.ConnectionString = @"Server=SCSBWIN-108289\SQLEXPRESS;Database=Tech_Find;Trusted_Connection=true";
                //conn.Open();


                //SqlCommand command = new SqlCommand("SP_FindTechnicianByLocation", conn);

                //command.CommandType = CommandType.StoredProcedure;

                DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = @"Server=SCSBWIN-108289\SQLEXPRESS;Database=Tech_Find;Trusted_Connection=true";
                SqlCommand sqlComm = new SqlCommand("SP_FindTechnicianByLocation", conn);
                sqlComm.Parameters.AddWithValue("@latitude", lat);
                sqlComm.Parameters.AddWithValue("@longitude", longitude);
                sqlComm.Parameters.AddWithValue("@skill", skill);

                sqlComm.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = sqlComm;

                da.Fill(ds);
            }
            return ds;

                //    //conn.Open();
                //    noOfRows= command.ExecuteNonQuery();
                //    conn.Close();

                //return noOfRows;

                //// Create the command
                //SqlCommand command = new SqlCommand("SELECT * FROM technician", conn);
                //// Add the parameters.
                ////command.Parameters.Add(new SqlParameter("0", 1));

                ///* Get the rows and display on the screen! 
                // * This section of the code has the basic code
                // * that will display the content from the Database Table
                // * on the screen using an SqlDataReader. */
                //int[] arr = new int[20];
                //int i = 1;
                //using (SqlDataReader reader = command.ExecuteReader())
                //{
                //    // Console.WriteLine("FirstColumn\tSecond Column\t\tThird Column\t\tForth Column\t");
                //    while (reader.Read())
                //    {
                //        //Console.WriteLine(String.Format("{0} \t | {1} \t | {2} \t | {3}",
                //        //    reader[0], reader[1], reader[2], reader[3]));
                //        arr[++i] = 1;

                //    }
                //}

                //return arr;

                // execute SP

            //}
           
        }
    }
}