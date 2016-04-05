package com.homer.data;

import com.google.common.collect.Lists;
import com.homer.type.*;
import com.homer.util.HomerBeanUtil;
import com.homer.util.core.IBaseObject;
import com.homer.util.core.data.IRepository;
import org.joda.time.DateTime;
import org.junit.Test;

import java.util.List;
import java.util.function.Consumer;

import static org.junit.Assert.*;

/**
 * Created by arigolub on 3/15/16.
 */
public class RepositoryTests {

    @Test
    public void testPlayerCRUD() throws Exception {
        Player player = new Player();
        player.setName("Ari Golub");
        player.setFirstName("Ari");
        player.setLastName("Golub");
        player.setPosition(Position.SHORTSTOP);
        player.setMlbTeamId(MLBTeam.NEWYORKYANKEES.getId());

        List<Consumer<Player>> funcs = Lists.newArrayList();
        funcs.add(p -> p.setPosition(Position.OUTFIELD));

        testCRUD(player, new PlayerRepository(), funcs);
    }

    @Test
    public void testPlayerSeasonCRUD() throws Exception {
        PlayerSeason playerSeason = new PlayerSeason();
        playerSeason.setSeason(2020);
        playerSeason.setPlayerId(1);
        playerSeason.setTeamId(1L);
        playerSeason.setFantasyPosition(Position.CATCHER);
        playerSeason.setKeeperTeamId(1L);
        playerSeason.setKeeperSeason(2020);
        playerSeason.setSalary(20);
        playerSeason.setIsMinorLeaguer(true);

        List<Consumer<PlayerSeason>> funcs = Lists.newArrayList();
        funcs.add(p -> p.setTeamId(2L));
        funcs.add(p -> p.setFantasyPosition(Position.FIRSTBASE));
        funcs.add(p -> p.setIsMinorLeaguer(false));

        testCRUD(playerSeason, new PlayerSeasonRepository(), funcs);
    }

    @Test
    public void testDraftDollarRepositoryCRUD() throws Exception {
        DraftDollar draftDollar = new DraftDollar();
        draftDollar.setSeason(2020);
        draftDollar.setTeamId(1);
        draftDollar.setAmount(100);
        draftDollar.setDraftDollarType(DraftDollarType.MLBAUCTION);

        List<Consumer<DraftDollar>> funcs = Lists.newArrayList();
        funcs.add(dd -> dd.setAmount(200));

        testCRUD(draftDollar, new DraftDollarRepository(), funcs);
    }

    @Test
    public void testMinorLeaguePickRepositoryCRUD() throws Exception {
        MinorLeaguePick minorLeaguePick = new MinorLeaguePick();
        minorLeaguePick.setOriginalTeamId(1);
        minorLeaguePick.setOwningTeamId(1);
        minorLeaguePick.setSeason(2020);
        minorLeaguePick.setRound(1);

        List<Consumer<MinorLeaguePick>> funcs = Lists.newArrayList();
        funcs.add(mlp -> mlp.setOwningTeamId(2));
        funcs.add(mlp -> mlp.setSwapTeamId(3L));
        funcs.add(mlp -> mlp.setPlayerId(1L));
        funcs.add(mlp -> mlp.setIsSkipped(false));
        funcs.add(mlp -> mlp.setNote("Swap with the other team"));

        testCRUD(minorLeaguePick, new MinorLeaguePickRepository(), funcs);
    }

    @Test
    public void testTradeCRUD() throws Exception {
        Trade trade = new Trade();
        trade.setTeam1Id(1);
        trade.setTeam2Id(2);
        trade.setTradeDate(DateTime.now().withMillisOfSecond(0));

        List<Consumer<Trade>> funcs = Lists.newArrayList();

        trade = testCRU(trade, new TradeRepository(), funcs);

        TradeElement tradeElement = new TradeElement();
        tradeElement.setTradeId(trade.getId());
        tradeElement.setTeamFromId(trade.getTeam1Id());
        tradeElement.setTeamToId(trade.getTeam2Id());

        TradeElement tradeElement2 = new TradeElement();
        HomerBeanUtil.copyProperties(tradeElement2, tradeElement);

        tradeElement.setPlayerId(1L);
        tradeElement2.setDraftDollarId(1L);
        tradeElement2.setDraftDollarAmount(10);

        TradeElementRepository tradeElementRepository = new TradeElementRepository();
        testCRU(tradeElement, tradeElementRepository, Lists.newArrayList());
        testCRU(tradeElement2, tradeElementRepository, Lists.newArrayList());
    }

    private <T extends IBaseObject> void testCRUD(T obj, IRepository<T> repo,
                                                    List<Consumer<T>> updaters) throws Exception {
        T updatedObj = testCRU(obj, repo, updaters);

        assertTrue(repo.delete(updatedObj));
        T deletedObj = repo.getById(updatedObj.getId());
        assertNull(deletedObj);
    }

    private <T extends IBaseObject> T testCRU(T obj, IRepository<T> repo,
                                                  List<Consumer<T>> updaters) throws Exception {
        T createdObj = repo.upsert(obj);
        assertNotNull(createdObj);
        obj.setId(createdObj.getId());
        assertEquals(obj, createdObj);

        T fetchedObj = repo.getById(createdObj.getId());
        assertEquals(createdObj, fetchedObj);

        updaters.forEach(u -> u.accept(createdObj));
        T updatedObj = repo.upsert(createdObj);
        assertNotNull(updatedObj);
        assertEquals(createdObj, updatedObj);

        return updatedObj;
    }
}