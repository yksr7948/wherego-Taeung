package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.trans.model.dao.TransDao;
import com.go.wherego.trans.model.vo.GTerminal;
import com.go.wherego.trans.model.vo.STerminal;


@Service
public class TransServiceImpl implements TransService{

	@Autowired
	private TransDao transdao;
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int saveGTerminalInfo(ArrayList<GTerminal> list) {
		return transdao.saveGTerminalInfo(sqlsession,list);
	}

	@Override
	public String getGTerminalCode(String GterminalNm) {
		return transdao.getGTerminalCode(sqlsession,GterminalNm );
	}

	@Override
	public int saveSTerminalInfo(ArrayList<STerminal> list) {
		return transdao.saveSTerminalInfo(sqlsession,list);
	}

	@Override
	public String getSTerminalCode(String SterminalNm) {
		return transdao.getSTerminalCode(sqlsession,SterminalNm);
	}


}
