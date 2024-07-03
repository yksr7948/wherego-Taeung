package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.trans.model.dao.TransDao;
import com.go.wherego.trans.model.vo.Terminal;


@Service
public class TransServiceImpl implements TransService{

	@Autowired
	private TransDao transdao;
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int saveTerminalInfo(ArrayList<Terminal> list) {
		return transdao.saveTerminalInfo(sqlsession,list);
	}

	@Override
	public String getTerminalCode(String terminalNm) {
		return transdao.getTerminalCode(sqlsession,terminalNm );
	}


}
