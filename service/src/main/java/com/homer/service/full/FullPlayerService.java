package com.homer.service.full;

import com.google.common.collect.Lists;
import com.homer.service.IPlayerSeasonService;
import com.homer.service.IPlayerService;
import com.homer.type.Player;
import com.homer.type.PlayerSeason;
import com.homer.type.view.PlayerSeasonView;
import com.homer.type.view.PlayerView;
import com.homer.util.LeagueUtil;

import java.util.List;

/**
 * Created by arigolub on 4/17/16.
 */
public class FullPlayerService implements IFullPlayerService {

    private IPlayerService playerService;
    private IPlayerSeasonService playerSeasonService;

    public FullPlayerService(IPlayerService playerService, IPlayerSeasonService playerSeasonService) {
        this.playerService = playerService;
        this.playerSeasonService = playerSeasonService;
    }

    @Override
    public PlayerView createPlayer(Player player) {
        Player createdPlayer = playerService.createPlayer(player);
        PlayerSeason playerSeason = playerSeasonService.createPlayerSeason(createdPlayer.getId(), LeagueUtil.SEASON);
        PlayerView view = PlayerView.from(createdPlayer);
        PlayerSeasonView playerSeasonView = PlayerSeasonView.from(playerSeason);
        List<PlayerSeasonView> playerSeasons = Lists.newArrayList(playerSeasonView);
        view.setPlayerSeasons(playerSeasons);
        return view;
    }
}