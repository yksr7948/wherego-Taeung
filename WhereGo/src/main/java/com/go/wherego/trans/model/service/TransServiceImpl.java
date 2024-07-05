package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.trans.model.dao.TransDao;
import com.go.wherego.trans.model.vo.GTerminal;
import com.go.wherego.trans.model.vo.Instant;
import com.go.wherego.trans.model.vo.STerminal;
import com.go.wherego.trans.model.vo.Train;


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

	@Override
	public ArrayList<String> likeSearch(String title) {
		return transdao.likeSearch(sqlsession,title);
	}


	@Override
	public ArrayList<String> arrivalLikeSearch(String title) {
		return transdao.arrivalLikeSearch(sqlsession,title);
	}

	@Override
	public int insertInstant(ArrayList<Instant> list) {
		return transdao.insertInstant(sqlsession, list);
	}

	@Override
	public int deleteInstant() {
		System.out.println("서비스");
		 return transdao.deleteInstant(sqlsession);
		
	}
	
	@Override
	public ArrayList<Train> getArea() {
		return transdao.getArea(sqlsession);
	}

	@Override
	public ArrayList<String> likeSSearch(String title) {
		return transdao.likeSSearch(sqlsession, title);
	}

	@Override
	public int insertSInstant(ArrayList<Instant> list) {
		return transdao.insertSInstant(sqlsession,list);
	}

	@Override
	public ArrayList<String> arrivalSLikeSearch(String title) {
		return transdao.arrivalSLikeSearch(sqlsession,title);
	}

	@Override
	public void deleteSInstant() {
		transdao.deleteSInstant(sqlsession);
		
	}


}
