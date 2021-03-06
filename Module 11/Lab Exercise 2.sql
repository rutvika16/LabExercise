USE [MarketDev]
GO
/****** Object:  Trigger [Marketing].[TR_CampaignBalance_Update]    Script Date: 15-04-2020 17:45:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [Marketing].[TR_CampaignBalance_Update]
ON [Marketing].[CampaignBalance]
AFTER UPDATE
AS BEGIN
  SET NOCOUNT ON;
  
  INSERT Marketing.CampaignAudit 
    (AuditTime, ModifyingUser, RemainingBalance)
  SELECT SYSDATETIME(),
         ORIGINAL_LOGIN(),
         inserted.RemainingBalance
  FROM deleted
  INNER JOIN inserted
  ON deleted.CampaignID = inserted.CampaignID 
  WHERE ABS(deleted.RemainingBalance- inserted.RemainingBalance) > 10000;
END;

DELETE FROM Marketing.CampaignAudit 

SELECT *FROM Marketing.CampaignBalance

UPDATE Marketing.CampaignBalance SET RemainingBalance = 55000 WHERE CampaignID=3;

SELECT * FROM Marketing.CampaignAudit
