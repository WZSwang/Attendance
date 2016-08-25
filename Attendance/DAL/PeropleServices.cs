using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Entity;

namespace DAL
{
    public class PeropleServices
    {
        public DataTable GetAllPeople()
        {
            string sql = "select * from Department right join UserInfo on UserInfo.DeptID=Department.DeptID";
            DataTable dt = DBhelper.Select(sql);
            return dt;
        }
        public DataTable GetAllDepart()
        {
            DataTable dt = new DataTable();
            dt = DBhelper.Select("select * from Department");
            return dt;
        }
        public DataTable  SearchPeople(string id, string name, string dept)
        {
            IList<UsersJionDepart> usersJionLog = new List<UsersJionDepart>();
            DataTable dt = DBhelper.Select(string.Format(
                "select * from Department right join UserInfo on UserInfo.DeptID=Department.DeptID where UserID like '%{0}%' and UserName like '%{1}%' and DeptName in ({2})"
                , id, name, dept));
            usersJionLog = ConvertHelper.convertToList<UsersJionDepart>(dt);
            return dt;
        }

        public void AddPeople(UserInfo us)
        {
            string sql;
            if (us.DeptID != null)
                 sql = string.Format(
                    "insert into  UserInfo values ('{0}','{1}','{2}',null,'{3}','{4}')"
                    , us.UserID, us.UserName, us.DeptID, us.Cellphone, us.UserType);
            else
                sql = string.Format(
                   "insert into  UserInfo values ('{0}','{1}',null,null,'{2}','{3}')"
                   , us.UserID, us.UserName, us.Cellphone, us.UserType);

            DBhelper.Change(sql);
        }

        public static bool UserIDPadding(string  id)
        {
            string sql = "select * from UserInfo  where UserID='"+ id + "'";
          DataTable dt=  DBhelper.Select(sql);
            return dt.Rows.Count > 0;
        }
        public static string UserInfos(string id)
        {
            string sql = "select * from UserInfo  where UserID='" + id + "'";
            DataTable dt = DBhelper.Select(sql);
            string user = dt.Rows[0]["UserType"].ToString() +","+ dt.Rows[0]["Cellphone"].ToString();
            return user;
        }


        //public bool Edit(UserInfo ps)
        //{
        //    var result = (from a in db.UserInfo
        //                  where a.UserId == ps.UserId
        //                  select a).First();
        //    result.UserId = ps.UserId;
        //    result.UserName = ps.UserName;
        //    result.UserPostno = ps.UserPostno;
        //    result.UserDeptno = ps.UserDeptno;
        //    result.UserBrith = ps.UserBrith;
        //    result.UserSex = ps.UserSex;
        //    result.UserWorkAge = ps.UserWorkAge;
        //    result.UserTel = ps.UserTel;
        //    result.Usertype = ps.Usertype;
        //    db.SubmitChanges();
        //    return true;
        //}

        //public IQueryable<Personnel> GMetinfo(string text)
        //{
        //    var result = from a in db.UserInfo
        //                 join b in db.Department on a.UserDeptno equals b.Deptno
        //                 join c in db.PostInfo on a.UserPostno equals c.Postno
        //                 select new Personnel
        //                 {
        //                     UserId = a.UserId,
        //                     UserName = a.UserName,
        //                     UserSex = a.UserSex,
        //                     UserBrith = a.UserBrith,
        //                     UserWorkAge = a.UserWorkAge,
        //                     UserTel = a.UserTel,
        //                     Usertype = a.Usertype,
        //                     Deptno = b.Deptno,
        //                     DeptName = b.DeptName,
        //                     PostClass = c.PostClass,
        //                     PostNo = c.Postno,
        //                     PostName = c.PostName
        //                 };
        //    return result;

        //}
        //public bool delete(UserInfo ps)
        //{
        //    var result = (from a in db.UserInfo
        //                  where a.UserId == ps.UserId
        //                  select a).First();
        //    db.UserInfo.DeleteOnSubmit(result);
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool insert(UserInfo ps)
        //{
        //    db.UserInfo.InsertOnSubmit(ps);
        //    db.SubmitChanges();
        //    return true;
        //}

        //public List<Department> Depart()
        //{
        //    var result = from a in db.Department select a;
        //    return result.ToList<Department>();
        //}
        //public List<PostInfo> Post(Personnel pr)
        //{
        //    var result = from a in db.PostInfo where a.PDeptno == pr.Deptno select a;
        //    return result.ToList<PostInfo>();
        //}
        //public List<PostInfo> Postanme()
        //{
        //    var result = from a in db.PostInfo select a;
        //    return result.ToList<PostInfo>();
        //}
        //public IQueryable<Personnel> Deptinfo(Personnel pr)
        //{
        //    var result = from a in db.UserInfo
        //                 join b in db.Department on a.UserDeptno equals b.Deptno
        //                 join c in db.PostInfo on a.UserPostno equals c.Postno
        //                 where a.UserPostno == pr.PostNo
        //                 select new Personnel
        //                 {
        //                     UserName = a.UserName,
        //                     DeptName = b.DeptName,
        //                     PostClass = c.PostClass,
        //                     PostName = c.PostName

        //                 };
        //    return result;
        //}
        //public bool DEdit(Personnel ps)
        //{
        //    var result = (from a in db.Department
        //                  join c in db.PostInfo on a.Deptno equals c.PDeptno
        //                  where a.Deptno == ps.Deptno
        //                  select new Personnel
        //                  {

        //                      DeptName = a.DeptName,
        //                      PostName = c.PostName
        //                  }).First();

        //    result.DeptName = ps.DeptName;
        //    result.PostName = ps.PostName;
        //    db.SubmitChanges();
        //    return true;
        //}
        //public bool Ddelete(Personnel ps)
        //{
        //    var result = (from a in db.Department
        //                  join c in db.PostInfo on a.Deptno equals c.PDeptno
        //                  where a.Deptno == ps.Deptno
        //                  select a).First();
        //    db.Department.DeleteOnSubmit(result);
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool useredit(Personnel ps)
        //{
        //    var query = (from a in db.UserInfo where a.UserName == ps.UserName select a).First();
        //    query.UserPostno = null;
        //    query.UserDeptno = null;
        //    db.SubmitChanges();
        //    return true;

        //}
        //public IQueryable<Personnel> Dpinfo(Personnel pr)
        //{
        //    var result = from a in db.UserInfo
        //                 join b in db.Department on a.UserDeptno equals b.Deptno
        //                 join c in db.PostInfo on a.UserPostno equals c.Postno
        //                 where a.UserPostno != pr.PostNo
        //                 select new Personnel
        //                 {
        //                     UserName = a.UserName,
        //                     DeptName = b.DeptName,
        //                     PostClass = c.PostClass,
        //                     PostName = c.PostName

        //                 };
        //    return result;
        //}
        //public bool userinfo(Personnel ps)
        //{
        //    var query = (from a in db.UserInfo where a.UserName == ps.UserName select a).First();
        //    query.UserPostno = ps.PostNo;
        //    query.UserDeptno = ps.Deptno;
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool postEdit(PostInfo pr)
        //{
        //    var query = (from a in db.UserInfo
        //                 join c in db.PostInfo on a.UserPostno equals c.Postno
        //                 where a.UserPostno == pr.Postno
        //                 select new PostInfo
        //                 {
        //                     //PostClass =pr.PostClass
        //                 }).First();
        //    query.PostClass = pr.PostClass;
        //    db.SubmitChanges();
        //    return true;


        //    //}
        //    //public bool postEdit(PostInfo pr)
        //    //{
        //    //    var query = (from a in db.PostInfo where a.Postno ==pr.Postno select a).First();
        //    //    query.PostClass = pr.PostClass;
        //    //    db.SubmitChanges();
        //    //    return true;
        //    //}
        //}



        /////sssss
        //public bool Edit(Personnel ps)
        //{
        //    var result = (from a in db.UserInfo
        //                  where a.UserId == ps.UserId
        //                  select a).First();
        //    result.UserName = ps.UserName;
        //    result.UserSex = ps.UserSex;
        //    result.UserBrith = ps.UserBrith;
        //    result.UserWorkAge = ps.UserWorkAge;
        //    result.UserTel = ps.UserTel;
        //    result.Usertype = ps.Usertype;
        //    result.UserDeptno = ps.Deptno;
        //    result.UserPostno = ps.PostNo;
        //    db.SubmitChanges();
        //    return true;
        //}

        //public bool delete(Personnel ps)
        //{
        //    var result = (from a in db.UserInfo
        //                  where a.UserId == ps.UserId
        //                  select a).First();
        //    db.UserInfo.DeleteOnSubmit(result);
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool insert(Personnel ps)
        //{
        //    UserInfo user = new UserInfo();
        //    Department de = new Department();
        //    PostInfo p = new PostInfo();
        //    user.UserId = ps.UserId;
        //    user.UserName = ps.UserName;
        //    user.UserPass = ps.UserPass;
        //    user.UserSex = ps.UserSex;
        //    user.UserBrith = ps.UserBrith;
        //    user.UserTel = ps.UserTel;
        //    user.Usertype = ps.Usertype;
        //    user.UserWorkAge = ps.UserWorkAge;
        //    user.UserDeptno = ps.Deptno;
        //    user.UserPostno = ps.PostNo;
        //    de.DeptName = ps.DeptName;
        //    p.PostClass = ps.PostClass;
        //    db.UserInfo.InsertOnSubmit(user);
        //    db.Department.InsertOnSubmit(de);
        //    db.PostInfo.InsertOnSubmit(p);
        //    db.SubmitChanges();
        //    return true;
        //}

        //public UserInfo user(UserInfo ps)
        //{
        //    var query = (from a in db.UserInfo where a.UserId == ps.UserId select a).First();
        //    return query;

        //}
        //public bool u(UserInfo ps)
        //{
        //    var query = (from a in db.UserInfo where a.UserId == ps.UserId select a).First();
        //    query.Userimage = ps.Userimage;
        //    //query.UserName = ps.UserName;
        //    //query.UserSex = ps.UserSex;
        //    query.UserTel = ps.UserTel;
        //    query.UserPass = ps.UserPass;
        //    query.Usertype = ps.Usertype;
        //    query.UserWorkAge = ps.UserWorkAge;
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool Mess(MessageBoard me)
        //{
        //    MessageBoard mess = new MessageBoard();
        //    mess.MUserId = me.MUserId;
        //    mess.Messages = me.Messages;
        //    db.MessageBoard.InsertOnSubmit(mess);
        //    db.SubmitChanges();
        //    return true;

        //}
        //public IQueryable<Personnel> messinfo(Personnel pr)
        //{
        //    var query = (from a in db.UserInfo
        //                 join c in db.MessageBoard on a.UserId equals c.MUserId
        //                 where c.MUserId == pr.MUserId
        //                 select new Personnel
        //                 {
        //                     UserName = a.UserName,
        //                     Messages = c.Messages,
        //                     MessageId = c.MessageId
        //                 });
        //    return query;
        //}
        //public bool Messdelete(MessageBoard mess)
        //{
        //    var result = (from a in db.MessageBoard
        //                  where a.MessageId == mess.MessageId
        //                  select a).First();
        //    db.MessageBoard.DeleteOnSubmit(result);
        //    db.SubmitChanges();
        //    return true;

        //}

        //public bool Isadmin(int usid)
        //{
        //    var result = (from a in db.PostInfo
        //                  where a.Postno == usid
        //                  select a).First();
        //    return result.PostClass;

        //}
        //public Department name(Department de)
        //{
        //    var query = (from a in db.Department where a.Deptno == de.Deptno select a).First();
        //    return query;
        //}
        //public PostInfo pname(PostInfo po)
        //{
        //    var query = (from a in db.PostInfo where a.Postno == po.Postno select a).First();
        //    return query;
        //}
        //public bool dename(Department dep)
        //{
        //    Department de = new Department();
        //    de.DeptName = dep.DeptName;
        //    db.Department.InsertOnSubmit(de);
        //    db.SubmitChanges();
        //    return true;

        //}
        //public bool addpname(PostInfo pos)
        //{
        //    PostInfo post = new PostInfo();
        //    post.PostName = pos.PostName;
        //    post.PDeptno = pos.PDeptno;
        //    post.PostClass = pos.PostClass;
        //    db.PostInfo.InsertOnSubmit(post);
        //    db.SubmitChanges();
        //    return true;
        //}
    }
}




