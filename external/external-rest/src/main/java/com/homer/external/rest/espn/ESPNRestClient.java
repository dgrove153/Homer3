package com.homer.external.rest.espn;

import com.homer.external.common.espn.ESPNPlayer;
import com.homer.external.common.espn.ESPNTransaction;
import com.homer.external.common.espn.IESPNClient;
import com.homer.external.rest.espn.parser.LeagueRosterParser;
import com.homer.external.rest.espn.parser.TeamRosterParser;
import com.homer.external.rest.espn.parser.TransactionsParser;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.mashape.unirest.request.HttpRequest;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nullable;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by arigolub on 7/25/16.
 */
public class ESPNRestClient implements IESPNClient {

    private static final Logger LOG = LoggerFactory.getLogger(ESPNRestClient.class);

    private static final int SEASON = 2017;

    private static final String URL_LEAGUEROSTERS   = "http://games.espn.go.com/flb/leaguerosters";
    private static final String URL_TRANSACTIONS    = "http://games.espn.go.com/flb/recentactivity";
    private static final String URL_TEAMROSTER      = "http://games.espn.go.com/flb/clubhouse";

    private static final String PARAM_LEAGUEID      = "leagueId";
    private static final String VALUE_LEAGUEID      = "216011";

    private static final String PARAM_SEASONID      = "seasonId";

    /**
     * Download and parse roster page into list of players, positions, teams
     * @return list of players
     * Example URL: http://games.espn.go.com/flb/leaguerosters?leagueId=216011
     */
    @Override
    public List<ESPNPlayer> getRosterPage() {
//        LOG.debug("BEGIN: getRosterPage");
//        List<ESPNPlayer> players = null;
//        Map<String, Object> parameters = new HashMap<String, Object>();
//        parameters.put(PARAM_LEAGUEID, VALUE_LEAGUEID);
//        try {
//            LOG.debug("Making request");
//            HttpResponse<InputStream> response = makeRequest(URL_LEAGUEROSTERS, parameters);
//            LOG.debug("Request finished, parsing");
//            String html = IOUtils.toString(response.getBody());
//            players = LeagueRosterParser.parse(html);
//
//            LOG.debug("Done parsing");
//        } catch (IOException e) {
//            LOG.error("IO exception", e);
//        }
//        int size = players != null ? players.size() : 0;
//        LOG.debug("END: getRosterPage, size: " + size);
//        return players;
        return null;
    }

    /**
     * Download and parse transactions from ESPN's Recent Activity page
     * Example URL: http://games.espn.go.com/flb/recentactivity?leagueId=216011&seasonId=2014&activityType=2&startDate=20140701&endDate=20140731&teamId=6&tranType=4
     * @param teamId teamId you are searching for
     * @param tranType transaction type you are searching for
     * @param startDate the date of the first transaction, format: yyyymmdd
     * @param endDate the date of the first transaction, format: yyyymmdd
     * @return list of transactions
     */
    @Override
    public List<ESPNTransaction> getTransactions(@Nullable Integer teamId, ESPNTransaction.Type tranType, String startDate, String endDate) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAM_LEAGUEID, VALUE_LEAGUEID);
        parameters.put(PARAM_SEASONID, SEASON);
        parameters.put("activityType", 2);
        parameters.put("startDate", startDate);
        parameters.put("endDate", endDate);
        if (teamId != null) {
            parameters.put("teamId", teamId);
        }
        parameters.put("tranType", tranType.getId());
        HttpResponse<InputStream> response = makeRequest(URL_TRANSACTIONS, parameters);
        List<ESPNTransaction> transactions = null;
        try {
            String html = IOUtils.toString(response.getBody());
            LOG.info("Request successful, parsing");
            transactions = TransactionsParser.parse(tranType, html);
        } catch (IOException e) {
            LOG.error("IO exception", e);
        }
        return transactions;
    }

    @Nullable
    public List<ESPNPlayer> getRoster(int teamId, int scoringPeriodId) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAM_LEAGUEID, VALUE_LEAGUEID);
        parameters.put(PARAM_SEASONID, SEASON);
        parameters.put("teamId", teamId);
        parameters.put("scoringPeriodId", scoringPeriodId);
        HttpResponse<InputStream> response = makeRequest(URL_TEAMROSTER, parameters);
        List<ESPNPlayer> espnPlayers = null;
        try {
            String html = IOUtils.toString(response.getBody());
            LOG.info("Request successful, parsing");
            espnPlayers = TeamRosterParser.parse(html, teamId);
        } catch (IOException e) {
            LOG.error("IO exception", e);
        }
        return espnPlayers;
    }

    private HttpResponse<InputStream> makeRequest(String url, Map<String, Object> parameters) {
        HttpResponse<InputStream> response = null;
        try {
            HttpRequest request = Unirest.get(url)
                    .queryString(parameters);
            LOG.info("Making request to URL " + request.getUrl());
            response = request.asBinary();
        } catch (UnirestException e) {
            LOG.error("Excepting fetching document", e);
        }
        return response;
    }
}
