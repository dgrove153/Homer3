package com.homer.data;

import com.homer.data.common.ITeamRepository;
import com.homer.type.Team;
import com.homer.util.data.BaseRepository;

/**
 * Created by arigolub on 3/15/16.
 */
public class TeamRepository extends BaseRepository<Team> implements ITeamRepository {

    public TeamRepository() {
        super(Team.class);
    }
}
