using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Entity
{
    public class ConvertHelper
    {
        /// <summary> 
        /// 单表查询结果转换成泛型集合 
        /// </summary> 
        /// <typeparam name="T">泛型集合类型</typeparam> 
        /// <param name="dt">查询结果DataTable</param> 
        /// <returns>以实体类为元素的泛型集合</returns> 
        public static IList<T> convertToList<T>(DataTable dt) where T : new()
        {
            // 定义集合 
            List<T> ts = new List<T>();

            // 获得此模型的类型 
            Type type = typeof(T);
            //定义一个临时变量 
            string tempName = string.Empty;
            //遍历DataTable中所有的数据行  
            foreach (DataRow dr in dt.Rows)
            {
                T t = new T();
                // 获得此模型的公共属性 
                PropertyInfo[] propertys = t.GetType().GetProperties();
                //遍历该对象的所有属性 
                foreach (PropertyInfo pi in propertys)
                {
                    tempName = pi.Name;//将属性名称赋值给临时变量   
                                       //检查DataTable是否包含此列（列名==对象的属性名）     
                    if (dt.Columns.Contains(tempName))
                    {
                        // 判断此属性是否有Setter   
                        if (!pi.CanWrite) continue;//该属性不可写，直接跳出   
                                                   //取值   
                        object value = dr[tempName];
                        //如果非空，则赋给对象的属性   
                        if (value != DBNull.Value)
                            pi.SetValue(t, value, null);
                    }
                }
                //对象添加到泛型集合中 
                ts.Add(t);
            }

            return ts;
        }



        /// <summary> 
        /// 两表查询结果转换成泛型集合 
        /// </summary> 
        /// <typeparam name="T">包含了两个表的实体类，聚合实体类</typeparam> 
        /// <typeparam name="U">实体类中的第一个实体类</typeparam> 
        /// <typeparam name="V">实体类中的第二个实体类</typeparam> 
        /// <param name="dt">从数据库中查询获得的DataTable</param> 
        /// <returns>以实体类为元素的泛型集合</returns> 
        public static IList<T> convertToJiontList<T, U, V>(DataTable dt)
            where T : new()
            where U : new()
            where V : new()
        {
            //定义一个聚合实体类泛型集合，用来做返回值 
            List<T> ts = new List<T>();
            //定义一个泛型集合元素，用来填充集合 
            T t = new T();
            //获取聚合实体类的属性 
            PropertyInfo[] propertys = t.GetType().GetProperties();
            //利用单表转换，把DataTable数据填充到聚合实体类中第一个实体类 
            IList<U> uList = new List<U>();
            uList = convertToList<U>(dt);
            //利用单表转换，把DataTable数据填充到聚合实体类中第二个实体类 
            IList<V> vList = new List<V>();
            vList = convertToList<V>(dt);

            //经过以上两步，uList和vList两个集合的长度肯定是相同的 

            //把两个实体类填充到聚合实体类中 
            for (int i = 0; i < uList.Count; i++)
            {
                propertys[0].SetValue(t, uList[i], null); //取uList中第i个元素，填充到聚合实体类的第一个属性中 
                propertys[1].SetValue(t, vList[i], null); //取vList中第i个元素，填充到聚合实体类的第二个属性中 

                ts.Add(  t); //向聚合实体类集合中添加元素 
            }
            return ts;
        }
    }
}