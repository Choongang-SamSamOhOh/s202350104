package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Favorite;

public interface FavoriteService {

	List<Favorite>       listFavorite(Favorite favorite);
	int 				 totalFavorite();

}