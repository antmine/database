use ADMINISTRATION;

insert into CRYPTO_CURRENCY values
  ('BTC', 'bitcoin');

delimiter //
create procedure INIT_WEBSITE_CRYPTO (in ID_WEBSITE char(10))
begin
  insert into CRYPTO_CURRENCY_WEBSITE values
  ('BTC', ID_WEBSITE, true);
end //
delimiter ;
