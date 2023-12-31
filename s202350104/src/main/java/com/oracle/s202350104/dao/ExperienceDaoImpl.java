package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ExperienceDaoImpl implements ExperienceDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public List<ExperienceContent> listExperience(ExperienceContent experience) {
		List<ExperienceContent> listExperience = null;
		
		try {
			listExperience = session.selectList("shExperienceListAll",experience);
			log.info("ExperienceDaoImpl listExperience() => " + listExperience.size());
		} catch (Exception e) {
			log.info("ExperienceDaoImpl listExperience() => " + e.getMessage());
		}
		return listExperience;
	}

	@Override
	public ExperienceContent detailExperience(int contentId) {
		ExperienceContent experience = new ExperienceContent();
		try {
			experience = session.selectOne("shExperienceDetail", contentId);
		} catch (Exception e) {
			
		}
		return experience;
	}

	@Override
	public int totalExperience() {
		int totalExperienceCnt = 0;
		try {
			totalExperienceCnt = session.selectOne("shExperienceTotal");
			log.info("totalExperienceCnt->"+totalExperienceCnt);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalExperienceCnt;
	}

	@Override
	public int experienceDelete(int contentId) {
		int experienceDelete = 0;
		try {
			experienceDelete = session.update("shExperienceDelete",contentId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return experienceDelete;
	}	

	@Override
	public int totalSearchExperience(ExperienceContent experience) {
		int totalSearchExperience = 0;
		try {
			totalSearchExperience = session.selectOne("shExperienceSearchTotal",experience);
			log.info("ExperienceDaoImpl totalSearchExperience()->"+totalSearchExperience);
		} catch (Exception e) {
			log.info("ExperienceDaoImpl totalSearchExperience ->"+e.getMessage() );
		}
		return totalSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSearchExperience(ExperienceContent experience) {
		List<ExperienceContent> listSearchExperience = null;
		
		try {
			listSearchExperience = session.selectList("shExperienceSearchListAll",experience);
			log.info("ExperienceDaoImpl listSearchExperience() => " + listSearchExperience.size());
		} catch (Exception e) {
			log.info("ExperienceDaoImpl listSearchExperience() => " + e.getMessage());
		}
		return listSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSmallCode(ExperienceContent experience) {
		List<ExperienceContent> listSmallCode = null;
		
		try {
			listSmallCode = session.selectList("shListSmallCodeAll",experience);
			log.info("ExperienceDaoImpl listSmallCode() => " + listSmallCode.size());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listSmallCode;
	}

	@Override
	public int experienceRestore(int contentId) {
		int experienceRestore = 0;
		try {
			experienceRestore = session.update("shExperienceRestore",contentId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return experienceRestore;
	}

	@Override
	public int experienceUpdate(ExperienceContent experienceContent) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.update("shContentsUpdate", experienceContent);
			log.info("updateExperience shContentsUpdate result => " + result);
			result = session.update("shExperienceUpdate", experienceContent);
			log.info("updateExperience shExperienceUpdate result => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("ExperienceDaoImpl updateExperience Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	@Override
	public int experienceApprove(ExperienceContent experienceContent) {
		int result = 0;
		try {
			result = session.update("shExperienceApprove", experienceContent);
		} catch(Exception e) {
			log.info("ExperienceDaoImpl experienceApprove Exception => " + e.getMessage());
		}
		
		return result;
	
	}

	@Override
	public int insertExperience(ExperienceContent experience) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.insert("shContentsInsert", experience);
			log.info("insertExperience shContentsInsert result => " + result);
			result = session.insert("shExperienceInsert", experience);
			log.info("insertExperience shExperienceInsert result => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("ExperienceDaoImpl shContentsInsert Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	@Override
	public int mainTotalExperience() {
		int mainTotalExperience = 0;
		try {
			mainTotalExperience = session.selectOne("shMainTotalExperience");
			log.info("mainTotalExperience->"+mainTotalExperience);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mainTotalExperience;
	}

	@Override
	public int totalMainSearchExperience(ExperienceContent experience) {
		int totalMainSearchExperience = 0;
		try {
			totalMainSearchExperience = session.selectOne("shMainExperienceSearchTotal", experience );
		} catch (Exception e) {
			log.info("totalMainSearchExperience->"+totalMainSearchExperience);
		}
		return totalMainSearchExperience;
	}

	@Override
	public List<ExperienceContent> listMainSearchExperience(ExperienceContent experience) {
		List<ExperienceContent> listMainSearchExperience = null;
		try {
			listMainSearchExperience = session.selectList("shMainExperienceSearchListAll",experience);
			
		} catch (Exception e) {
			log.info("listMainSearchExperience->"+e.getMessage());
		}
		return listMainSearchExperience;
	}
}
