package com.homer.service;

import com.google.common.collect.Lists;
import com.homer.type.Player;
import com.homer.util.core.$;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.List;

/**
 * Created by arigolub on 3/15/16.
 */
public interface IPlayerService extends IIdService<Player> {

    List<Player> getPlayers();

    List<Player> getPlayersByNames(Collection<String> names);
    @Nullable
    default Player getPlayerByName(String name) {
        return $.of(getPlayersByNames(Lists.newArrayList(name))).first();
    }

    List<Player> searchPlayersByName(String search);
}