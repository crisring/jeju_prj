package kr.co.sist.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisHandler {

	private static MyBatisHandler mbh;
	private static SqlSessionFactory ssf;

	private MyBatisHandler() {
		org.apache.ibatis.logging.LogFactory.useLog4J2Logging();

	}// constructor

	public static MyBatisHandler getInstnace() {
		if (mbh == null) {
			mbh = new MyBatisHandler();
		} // if
		return mbh;
	}// getInstance

	private static SqlSessionFactory createMybatis() {
		if (ssf == null) {

			String configPath = "kr/co/sist/dao/mybatis_config.xml";
			try {
				// 1.설정파일과 연결
				Reader reader = Resources.getResourceAsReader(configPath);
				// 2.MyBatis Framework생성..
				ssf = new SqlSessionFactoryBuilder().build(reader);
				if (reader != null) {
					reader.close();
				} // end if
			} catch (IOException e) {
				e.printStackTrace();
			} // end catch

		} // end if
		return ssf;
	}// createMybatis

	/**
	 * true : autocommint flase : not autocommit
	 * 
	 * @param autoCommitFlag
	 * @return
	 */
	public SqlSession getHandler(boolean autoCommitFlag) {

		return createMybatis().openSession(autoCommitFlag);
	}// getHandler

	/**
	 * autocommit이 수행되지 않는다
	 * 
	 * @return
	 */
	public SqlSession getHandler() {
		return createMybatis().openSession();
	}// getHandler

	public void closeHandler(SqlSession ss) {

		if (ss != null) {
			ss.close();
		} // end if
	}// closeHandler

}// class
