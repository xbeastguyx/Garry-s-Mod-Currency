GCurrency = GCurrency or {}

function GCurrency:Add( player, type, amount )
	local currencyTypes = {
		[ "darkrp" ] = function( player, amount ) player:addMoney( amount ) end,
		[ "pointshop1" ] = function( player, amount ) player:PS_GivePoints( amount ) end,
		[ "pointshop2_standard" ] = function( player, amount ) player:PS2_AddStandardPoints( amount ) end,
		[ "pointshop2_premium" ] = function( player, amount ) player:PS2_AddPremiumPoints( amount ) end
	}
  
	if !currencyTypes[ type:lower() ] then
		error "Invalid currency specified!"
	end
  
	currencyTypes[ type:lower() ]( player, amount )
end

function GCurrency:Take( player, type, amount )
	local currencyTypes = {
		[ "darkrp" ] = function( player, amount ) player:addMoney( -amount ) end,
		[ "pointshop1" ] = function( player, amount ) player:PS_TakePoints( amount ) end,
		[ "pointshop2_standard" ] = function( player, amount ) player:PS2_AddStandardPoints( -amount ) end,
		[ "pointshop2_premium" ] = function( player, amount ) player:PS2_AddPremiumPoints( -amount ) end
	}
  
	if !currencyTypes[ type:lower() ] then
		error "Invalid currency set!"
	end
  
	currencyTypes[ type:lower() ]( player, amount )
end

function GCurrency:Get( player, type )
	local amount

	local currencyTypes = {
		[ "darkrp" ] = function( player ) amount = player:getDarkRPVar( "money" ) end,
		[ "pointshop1" ] = function( player ) amount = player:PS_GetPoints() end,
		[ "pointshop2_standard" ] = function( player ) if player.PS2_Wallet then amount = player.PS2_Wallet.points end end,
		[ "pointshop2_premium" ] = function( player ) if player.PS2_Wallet then amount = player.PS2_Wallet.premiumPoints end end
	}
  
	if amount == nil or !currencyTypes[ type:lower() ] then
		error "Invalid currency set!"
	end 
  
	currencyTypes[ type ]( player )
end
