package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.RestaurantsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AccomodationDaoImpl implements AccomodationDao {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public List<AccomodationContent> listAccomodation(AccomodationContent accomodation) {
		
		List<AccomodationContent> listAccomodation = null;
		log.info("AccomodationImpl listAccomodations Start...");
		
		try {
			listAccomodation = session.selectList("accomodationAll", accomodation);
			log.info("AccomodationDaoImpl listAccomodation AccomodationsList.size()->" + listAccomodation.size());
		} catch (Exception e) {
			log.info("AccomodationDaoImpl listAccomodation e.getMessage()->" + e.getMessage());
		}
		
		return listAccomodation;
	}

	@Override
	public AccomodationContent detailAccomodation(int contentId) {
	AccomodationContent accomodation = new AccomodationContent();
		
		try {
			accomodation = session.selectOne("AccomodationDetail", contentId);
			log.info("accomodationContent detailaccomodation() accomodation.getTitle ->" + accomodation.getTitle());
					
		} catch (Exception e) {
			log.info("accomodationsContent detailaccomodation() ->" + e.getMessage());
		}
		return accomodation;
	}

	@Override
	public int totalAccomodation() {
		int totAccomodationCount = 0;
		
		try {
			totAccomodationCount = session.selectOne("AccomodationTotalIndex");
		} catch (Exception e) {
			log.info("AccomodationDaoImpl totalAccomodations Exception => " + e.getMessage());
		}
		return totAccomodationCount;
	}

	@Override
	public int accomodationDelete(int contentId) {
		int accomodationDelete = 0;
		try {
			accomodationDelete = session.delete("accomodationDelete",contentId);
		} catch (Exception e) {
		}
		
		return accomodationDelete;
	}
	
	@Override
	public int insertContent(AccomodationContent accomodation) {
		int result = 0;
		try {
			result = session.insert("ContentsInsert", accomodation);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl insertContent Exception => " + e.getMessage());
		}
		
		return result;
	}
	
	@Override
	public int insertAccomodation(AccomodationContent accomodation) {
		int result = 0;
		try {
			result = session.insert("AccomodationInsert", accomodation);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl insertAccomodation Exception => " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int updateAccomodation(AccomodationContent accomodation) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.update("ContentsUpdate", accomodation);
			log.info("updateAccomodation ContentsUpdate result => " + result);
			result = session.update("AccomodationUpdate", accomodation);
			log.info("updateAccomodation AccomodationUpdate result => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("AccomodationDaoImpl updateAccomodation Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	@Override
	public int approveAccomodation(AccomodationContent accomodation) {
		int result = 0;
		try {
			result = session.update("AccomodationApprove", accomodation);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl approveFestival Exception => " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public List<AccomodationContent> listSmallCode(AccomodationContent accomodationContent) {
		
		List<AccomodationContent> listSmallCode = null;
		
		try {
			listSmallCode = session.selectList("syListSmallCodeAll",accomodationContent);
			log.info("AccomodationDaoImpl listSmallCode() => " + listSmallCode.size());
		} catch (Exception e) {
			 log.error("Exception in listSmallCode method: " + e.getMessage());
		}
		return listSmallCode;
	}

	@Override
	public List<AccomodationContent> listSearchAccomodation(AccomodationContent accomodationContent) {
		
		List<AccomodationContent> listSearchAccomodation = null;
		
		try {
			listSearchAccomodation = session.selectList("syAccomodationSearchListAll",accomodationContent);
			log.info("AccomodationDaoImpl listSearchExperience() => " + listSearchAccomodation.size());
				
		} catch (Exception e) {
			log.info("AccomodationDaoImpl listSearchExperience() => " + e.getMessage());
		}
		return listSearchAccomodation;
	}

	@Override
	public int totalSearchAccomodation(AccomodationContent accomodationContent) {
		int totalSearchAccomodation = 0;
		try {
			totalSearchAccomodation = session.selectOne("syAccomodationSearchTotal",accomodationContent);
			log.info("AccomodationDaoImpl totalSearchAccomodation()->"+totalSearchAccomodation);
		} catch (Exception e) {
			log.info("AccomodationDaoImpl totalSearchAccomodation ->"+e.getMessage() );
		}
		return totalSearchAccomodation;
	}

	@Override
	public int conTotalAccomdation(AccomodationContent accomodation) {
		int conTotalAccomodation = 0;
		try {
			conTotalAccomodation = session.selectOne("ConTotalAccomodation", accomodation);
		} catch (Exception e) {
			log.info("AccomodationDaoImpl ConTotalAccomodation() Exception ->" + e.getMessage());
		}
				
		return conTotalAccomodation;
		}

	@Override
	public List<AccomodationContent> indexlistSearchAccomodation(AccomodationContent accomodation) {
		List<AccomodationContent> indexlistSearchAccomodation = null;
		try {
			indexlistSearchAccomodation = session.selectList("IndexlistSearchAccomodation", accomodation);
		} catch (Exception e) {
			 log.info("AccomodationDaoImpl indexlistSearchAccomodation() Exception ->" + e.getMessage());
		}
		return indexlistSearchAccomodation;
	}

	@Override
	public int admintotalAccomodation() {
		int totAccomodationCount = 0;
		
		try {
			totAccomodationCount = session.selectOne("AccomodationTotal");
		} catch (Exception e) {
			log.info("AccomodationDaoImpl totalAccomodations Exception => " + e.getMessage());
		}
		return totAccomodationCount;
	}

	@Override
	public int accomodationRestore(int contentId) {
		int accomodationRestore = 0;
		try {
			accomodationRestore = session.update("syAccomodaitonRestore",contentId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return accomodationRestore;
	}
}