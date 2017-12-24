use ADMINISTRATION;
insert into CRYPTO_CURRENCY values
  ('BTC', 'bitcoin');
insert into WALLET_AUTH (TOKEN, ID_BITGO_WALLET) values
  ('v2xfa9b3ec7f9b2a8b957df748d63e2d3ea85674eba5237c11d3d1cdc929d3a6db2', '5a2aaf339a42a23b073150a384ce055b');

delimiter //
create procedure INIT_WEBSITE_CRYPTO (in ID_WEBSITE char(10))
begin
  insert into CRYPTO_CURRENCY_WEBSITE values
  ('BTC', ID_WEBSITE, true);
end //
delimiter ;
