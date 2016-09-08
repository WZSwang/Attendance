using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public static class DBhelper
    {
        static string conf = "Data Source=.;Initial Catalog=Attendance;Integrated Security=True";
        public static int Change(string sql)
        {
            SqlConnection sqlcon = new SqlConnection(conf);
            sqlcon.Open();
            SqlCommand sqlcom = new SqlCommand(sql, sqlcon);
            int result = sqlcom.ExecuteNonQuery();
            sqlcon.Close();
            return result;
        }

        public static DataTable Select(string sql)
        {
            SqlConnection sqlcon = new SqlConnection(conf);
            SqlDataAdapter ad = new SqlDataAdapter(sql, sqlcon);
            sqlcon.Open();
            DataTable dt = new DataTable();
            ad.Fill(dt);
            sqlcon.Close();
            return dt;
        }

        public static void TransactioChange(List<string> sqllist)
        {
            SqlConnection sqlcon = new SqlConnection(conf);
            sqlcon.Open();
            SqlTransaction sqltra = sqlcon.BeginTransaction();
            try
            {
                foreach (string sql in sqllist)
                {
                    SqlCommand sqlcom = new SqlCommand(sql, sqlcon, sqltra);
                    sqlcom.ExecuteNonQuery();
                }
                sqltra.Commit();
            }
            catch
            {
                sqltra.Rollback();
            }
            finally
            {
                sqlcon.Close();
            }
        }






    }
}
