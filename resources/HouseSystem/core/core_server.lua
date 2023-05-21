local sql = { Query = executeSQLQuery };

addEventHandler( 'onResourceStart', resourceRoot, function()
  sql.Query( "CREATE TABLE IF NOT EXISTS house_data (\
    ID INTEGER, en_X REAL, en_Y REAL, en_Z REAL,\
    en_tX REAL, en_tY REAL, en_tZ REAL,\
    ex_X REAL, ex_Y REAL, ex_Z REAL,\
    ex_tX REAL, ex_tY REAL, ex_tZ REAL,\
    int INTEGER, dim INTEGER, cost INTEGER, owner TEXT, key TEXT )"
  );
  for i, v in ipairs( getElementsByType( 'player' ) ) do
    setElementData( v, 'k_len', tonumber( get( 'keyLength' ) ) );
    local acc = getPlayerAccount( v );
    if not isGuestAccount( acc ) then
      setElementData( v, 'HS_accountName', getAccountName( acc ) );
    end;
    setElementData( v, 'mrk_in', nil );
  end;
  local hr = sql.Query( "SELECT * FROM house_data" );
  for i = 1, #hr do
    createHouse( false, hr[i].ID, hr[i].owner, hr[i].key, hr[i].en_X, hr[i].en_Y, hr[i].en_Z, hr[i].en_tX, hr[i].en_tY, hr[i].en_tZ, hr[i].ex_X, hr[i].ex_Y, hr[i].ex_Z, hr[i].ex_tX, hr[i].ex_tY, hr[i].ex_tZ, hr[i].int, hr[i].dim, hr[i].cost );
  end;
end );

addEventHandler( 'onResourceStop', resourceRoot, function()
  for i, v in ipairs( getElementsByType( 'player' ) ) do
    setElementData( v, 'k_len', nil );
    setElementData( v, 'HS_accountName', nil );
  end;
end );

addEventHandler( 'onPlayerJoin', root, function()
  setElementData( source, 'k_len', tonumber( get( 'keyLength' ) ) );
end );

addEventHandler( 'onPlayerLogin', root, function( _, acc )
  setElementData( source, 'HS_accountName', getAccountName( acc ) );
end );

addEventHandler( 'onPlayerLoout', root, function( _, acc )
  setElementData( source, 'HS_accountName', nil );
end );

addCommandHandler( 'hpanel', function( player )
  if isObjectInACLGroup( 'user.'..getAccountName( getPlayerAccount( player ) ), aclGetGroup( 'Level 5' ) ) or hasObjectPermissionTo( player, 'function.banPlayer', false ) then
    if not getElementData( player, 'HP_Opened' ) and not getElementData( player, 'mrk_in' ) then
      triggerClientEvent( player, 'HP_SetVisible', root, true );
    end;
  else
    outputChatBox( '* Access denied for this command!', player, 255, 36, 51 );
  end;
end );

addEvent( 'onPlayerAttemptCreateHouse', true );
addEventHandler( 'onPlayerAttemptCreateHouse', root, function( rt )
  createHouse( true, #sql.Query( "SELECT * FROM house_data" ) + 1, '', '', unpack( rt ) );
  outputChatBox( '* The new house has been created successfully!', client, 255, 255, 0 );
end );

function createHouse( add, ID, owner, key, eX, eY, eZ, etX, etY, etZ, exX, exY, exZ, extX, extY, extZ, int, dim, cost )
  if add then
    sql.Query( "INSERT INTO house_data ( ID, en_X, en_Y, en_Z, en_tX, en_tY, en_tZ, ex_X, ex_Y, ex_Z, ex_tX, ex_tY, ex_tZ, int, dim, cost, owner, key ) VALUES ( "..ID..", "..eX..", "..eY..", "..eZ..", "..etX..", "..etY..", "..etZ..", "..exX..", "..exY..", "..exZ..", "..extX..", "..extY..", "..extZ..", "..int..", "..dim..", "..cost..", '', '' )" );
  end;
  
  local m_Enter = createMarker( eX, eY, eZ - 1, 'cylinder', 1.25, 0, 153, 255, 150 );
  setElementData( m_Enter, 'HS_INFO', { etX, etY, etZ, int, dim, cost, owner, key, ID } );
  
  if getElementData( m_Enter, 'HS_INFO' )[7] ~= '' then
    setMarkerColor( m_Enter, 255, 51, 36, 150 );
  end;
  
  addEventHandler( 'onMarkerHit', m_Enter, function( player )
    if getElementType( player ) == 'player' and not getPedOccupiedVehicle( player ) then
      if not getElementData( player, 'HP_Opened' ) then
        if not isGuestAccount( getPlayerAccount( player ) ) then
          setElementData( player, 'mrk_in', getElementData( source, 'HS_INFO' )[9] );
          onPlayerHouseMarkerHit( player, source, true );
          setElementFrozen( player, true );
        else
          outputChatBox( '* You must be logged in to get in this house!', player, 255, 51, 36 );
        end;
      end;
    end;
  end );
  
  addEventHandler( 'onMarkerLeave', m_Enter, function( player )
    if getElementType( player ) == 'player' and not getPedOccupiedVehicle( player ) then
      setElementData( player, 'mrk_in', nil );
    end;
  end );
  
  local m_Exit = createMarker( exX, exY, exZ - 1, 'cylinder', 1.25, 0, 153, 255, 150 );
  setElementData( m_Exit, 'parent', m_Enter );
  setElementInterior( m_Exit, int );
  setElementDimension( m_Exit, dim );
  
  setElementData( m_Exit, 'extX', extX );
  setElementData( m_Exit, 'extY', extY );
  setElementData( m_Exit, 'extZ', extZ );
  
  addEventHandler( 'onMarkerHit', m_Exit, function( player, dim )
    if getElementType( player ) == 'player' and dim then
      toggleAllControls( player, false );
      fadeCamera( player, false );
      setTimer( function( player, mrk )
        if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ); end;
        local x, y, z = getElementData( mrk, 'extX' ), getElementData( mrk, 'extY' ), getElementData( mrk, 'extZ' );
        setElementPosition( player, x, y, z );
        setElementInterior( player, 0 );
        setElementDimension( player, 0 );
        toggleAllControls( player, true );
        fadeCamera( player, true );
      end, 1200, 1, player, source );
    end;
  end );
end;

function onPlayerHouseMarkerHit( player, mrk, cursor )
  local acc = getPlayerAccount( player );
  if isGuestAccount( acc ) then
    outputChatBox( '* You must be logged in to get in this house!', player, 255, 51, 36 );
    setElementData( player, 'mrk_in', nil );
    setElementFrozen( player, false );
    return false;
  end;
  local tts = { [1] = true, [2] = false, [3] = false, [4] = true, [5] = false, [6] = false };
  if isObjectInACLGroup( 'user.'..getAccountName( acc ), aclGetGroup( 'Level 5' ) ) or hasObjectPermissionTo( player, 'function.banPlayer', false ) then
    tts[6] = true;
  end;
  local owner = getElementData( mrk, 'HS_INFO' )[7];
  local accName = getAccountName( acc );
  if owner == accName then
    tts[1] = false;
    tts[2] = true;
    tts[3] = true;
    tts[4] = true;
    tts[5] = true;
  end;
  if owner ~= accName and owner ~= '' then
    tts[1] = false;
  end;
  if owner == '' then
    if isObjectInACLGroup( 'user.'..getAccountName( acc ), aclGetGroup( 'Level 5' ) ) or hasObjectPermissionTo( player, 'function.banPlayer', false ) then
      tts[4] = true;
    else
      tts[4] = false;
    end;
  end;
  tts[7] = getElementData( mrk, 'HS_INFO' )[9];
  tts[8] = getElementData( mrk, 'HS_INFO' )[7];
  tts[9] = getElementData( mrk, 'HS_INFO' )[6];
  triggerClientEvent( player, 'openHouseManagementWnd', root, tts, cursor );
end;

addEvent( 'HOUSE_Buy', true );
addEventHandler( 'HOUSE_Buy', root, function( cost, key )
  local accName = getAccountName( getPlayerAccount( client ) );
  local houseCounter = 0;
  for i, v in ipairs( getElementsByType( 'marker', getResourceRootElement() ) ) do
    if getElementData( v, 'HS_INFO' ) then
      local owner = getElementData( v, 'HS_INFO' )[7];
      if owner == accName then
        houseCounter = houseCounter + 1;
      end;
    end;
  end;
  if houseCounter >= tonumber( get( 'playerHouseCounter' ) ) then
    outputChatBox( '* You can not buy more than #00FF00'..get( 'playerHouseCounter' )..' house(-s)#FF3324 at the same time!', client, 255, 51, 36, true );
    setElementFrozen( client, false );
    return false;
  end;
  if getPlayerMoney( client ) >= tonumber( cost ) then
    outputChatBox( '* Key has been set to #00FF00'..key, client, 255, 51, 36, true );
    outputChatBox( '* Congratulations! You have bought a house!', client, 255, 255, 0 );
    sql.Query( "UPDATE house_data SET owner = '"..accName.."', key = '"..key.."' WHERE ID = ?", getElementData( client, 'mrk_in' ) );
    takePlayerMoney( client, cost );
    local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
    local t = {};
    for i = 1, 6 do
      t[i] = getElementData( mrk, 'HS_INFO' )[i];
    end;
    t[7] = accName;
    t[8] = key;
    t[9] = getElementData( client, 'mrk_in' );
    setElementData( mrk, 'HS_INFO', { t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9] } );
    setMarkerColor( mrk, 255, 51, 36, 150 );
    setTimer( onPlayerHouseMarkerHit, 50, 1, client, mrk, true );
  else
    outputChatBox( '* You do not have enough money!', client, 255, 51, 36 );
    onPlayerHouseMarkerHit( client, getHouseByID( getElementData( client, 'mrk_in' ) ), true );
  end;
end );

addEvent( 'HOUSE_Sell', true );
addEventHandler( 'HOUSE_Sell', root, function()
  sql.Query( "UPDATE house_data SET owner = '', key = '' WHERE ID = ?", getElementData( client, 'mrk_in' ) );
    local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
    givePlayerMoney( client, getElementData( mrk, 'HS_INFO' )[6] / 2 );
    local t = {};
    for i = 1, 6 do
      t[i] = getElementData( mrk, 'HS_INFO' )[i];
    end;
    t[7] = '';
    t[8] = '';
    t[9] = getElementData( client, 'mrk_in' );
    setElementData( mrk, 'HS_INFO', { t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9] } );
    setMarkerColor( mrk, 0, 153, 255, 150 );
    setTimer( onPlayerHouseMarkerHit, 50, 1, client, mrk, false );
  end
);

addEvent( 'HOUSE_Enter', true );
addEventHandler( 'HOUSE_Enter', root, function()
  setElementFrozen( client, false );
  local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
  local t = {};
  for i = 1, 5 do
    t[i] = getElementData( mrk, 'HS_INFO' )[i];
  end;
  fadeCamera( client, false );
  toggleAllControls( client, false );
  setTimer( function( player, t )
    if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ); end;
    setElementInterior( player, t[4], t[1], t[2], t[3] );
    setElementDimension( player, t[5] );
    toggleAllControls( player, true );
    fadeCamera( player, true );
    setElementData( player, 'mrk_in', nil )
  end, 1200, 1, client, t );
end );

addEvent( 'HOUSE_ChangeKey', true );
addEventHandler( 'HOUSE_ChangeKey', root, function( newKey )
  local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
  sql.Query( "UPDATE house_data SET key = '"..newKey.."' WHERE ID = ?", getElementData( client, 'mrk_in' ) );
  local t = {};
  for i = 1, 6 do
    t[i] = getElementData( mrk, 'HS_INFO' )[i];
  end;
  t[7] = getAccountName( getPlayerAccount( client ) );
  t[8] = newKey;
  t[9] = getElementData( client, 'mrk_in' );
  setElementData( mrk, 'HS_INFO', { t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9] } );
end );

addEvent( 'HOUSE_ChangeOwner', true );
addEventHandler( 'HOUSE_ChangeOwner', root, function( name )
  local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
  local accName = getAccountName( getPlayerAccount( getPlayerFromName( name ) ) );
  sql.Query( "UPDATE house_data SET owner = '"..accName.."' WHERE ID = ?", getElementData( client, 'mrk_in' ) );
  local res = sql.Query( "SELECT key, owner FROM house_data WHERE ID = ?", getElementData( client, 'mrk_in' ) );
  local t = {};
  for i = 1, 6 do
    t[i] = getElementData( mrk, 'HS_INFO' )[i];
  end;
  t[7] = res[1].owner;
  t[8] = res[1].key;
  t[9] = getElementData( client, 'mrk_in' );
  setElementData( mrk, 'HS_INFO', { t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9] } );
  setTimer( onPlayerHouseMarkerHit, 50, 1, client, mrk, false );
  outputChatBox( '* #FFFF00'..getPlayerName( client )..'#00FF00 has given you his house!', getPlayerFromName( name ), 0, 255, 0, true );
end );

addEvent( 'HOUSE_Destroy', true );
addEventHandler( 'HOUSE_Destroy', root, function()
  local mrk = getHouseByID( getElementData( client, 'mrk_in' ) );
  for ii, v in ipairs( getElementsByType( 'marker', getResourceRootElement() ) ) do
    if getElementData( v, 'parent' ) == mrk then
      destroyElement( v );
    end;
  end;
  local hr = sql.Query( "SELECT * FROM house_data" );
  for i = getElementData( source, 'mrk_in' ), #hr do
    if getHouseByID( i ) ~= mrk then
      sql.Query( "UPDATE house_data SET ID = "..( i - 1 ).." WHERE ID = ?", i );
      local res = sql.Query( "SELECT owner, key FROM house_data WHERE ID = ?", i - 1 );
      local nextMrk = getHouseByID( i );
      local t = {};
      for i = 1, 6 do
        t[i] = getElementData( nextMrk, 'HS_INFO' )[i];
      end;
      t[7] = res[1].owner;
      t[8] = res[1].key;
      t[9] = i - 1;
      setElementData( nextMrk, 'HS_INFO', { t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9] } );
      local player = getPlayerByHouseID( i - 1 );
      setElementData( player, 'mrk_in', i - 1 );
    else
      sql.Query( "DELETE FROM house_data WHERE ID = ?", i );
      destroyElement( mrk );
    end;
  end;
  outputChatBox( '* House #'..getElementData( source, 'mrk_in' )..' has been destroyed!', source, 255, 255, 0 );
  setElementFrozen( source, false );
  setElementData( source, 'mrk_in', nil );
end );

function getHouseByID( id )
  for i, v in ipairs( getElementsByType( 'marker', getResourceRootElement() ) ) do
    if getElementData( v, 'HS_INFO' ) and getElementData( v, 'HS_INFO' )[9] == id then
      return v;
    end;
  end;
  return false;
end;

function getPlayerByHouseID( id )
  for i, v in ipairs( getElementsByType( 'player' ) ) do
    if getElementData( v, 'mrk_in' ) == id then
      return v;
    end;
  end;
  return false;
end;

addEvent( 'setFrozen', true );
addEventHandler( 'setFrozen', root, function( state )
  setElementFrozen( client, state );
end );

addEventHandler( 'onPlayerWasted', root, function()
  if getElementData( source, 'mrk_in' ) then
    setElementData( source, 'mrk_in', nil );
    setElementFrozen( source, false );
  end;
end );
