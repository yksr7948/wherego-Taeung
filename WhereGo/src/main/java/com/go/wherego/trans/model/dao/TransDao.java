package com.go.wherego.trans.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.trans.model.vo.Terminal;



@Repository
public class TransDao {

	public int saveTerminalInfo(SqlSessionTemplate sqlsession, ArrayList<Terminal> list) {
		return sqlsession.insert("transMapper.saveTerminalInfo",list);
	}

	public String getTerminalCode(SqlSessionTemplate sqlsession, String terminalNm) {
		return sqlsession.selectOne("transMapper.getTerminalCode",terminalNm);
	}

}
