package com.go.wherego.trans.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.trans.model.vo.GTerminal;
import com.go.wherego.trans.model.vo.Instant;
import com.go.wherego.trans.model.vo.STerminal;
import com.go.wherego.trans.model.vo.Train;




@Repository
public class TransDao {

	public int saveGTerminalInfo(SqlSessionTemplate sqlsession, ArrayList<GTerminal> list) {
		return sqlsession.insert("transMapper.saveGTerminalInfo",list);
	}

	public String getGTerminalCode(SqlSessionTemplate sqlsession, String GterminalNm) {
		return sqlsession.selectOne("transMapper.getGTerminalCode",GterminalNm);
	}

	public int saveSTerminalInfo(SqlSessionTemplate sqlsession, ArrayList<STerminal> list) {
		return sqlsession.insert("transMapper.saveSTerminalInfo",list);
	}

	public String getSTerminalCode(SqlSessionTemplate sqlsession, String SterminalNm) {
		return sqlsession.selectOne("transMapper.getSTerminalCode",SterminalNm);
	}

	public ArrayList<String> likeSearch(SqlSessionTemplate sqlsession, String title) {
		return (ArrayList)sqlsession.selectList("transMapper.likeSearch",title);
	}

	public int insertInstant(SqlSessionTemplate sqlsession, ArrayList<Instant> list) {
		return sqlsession.insert("transMapper.insertInstant",list);
	}

	public ArrayList<String> arrivalLikeSearch(SqlSessionTemplate sqlsession, String title) {
		return (ArrayList)sqlsession.selectList("transMapper.arrivalLikeSearch",title);
	}

	public int deleteInstant(SqlSessionTemplate sqlsession) {
		System.out.println("dao");
		return sqlsession.delete("transMapper.deleteInstant");
		
	}
	
	public ArrayList<Train> getArea(SqlSessionTemplate sqlsession) {
		return (ArrayList)sqlsession.selectList("transMapper.selectCitycode");
	}

}
