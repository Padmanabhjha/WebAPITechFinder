﻿CREATE TABLE [dbo].[Locations] (
    [LocationId] INT            IDENTITY (1, 1) NOT NULL,
    [Latitute]   REAL           NOT NULL,
    [Longitute]  REAL           NOT NULL,
    [Area]       NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Locations] PRIMARY KEY CLUSTERED ([LocationId] ASC)
);

CREATE TABLE [dbo].[Skills] (
    [SkillId]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX) NULL,
    [SkillType] INT            NOT NULL,
    CONSTRAINT [PK_dbo.Skills] PRIMARY KEY CLUSTERED ([SkillId] ASC)
);

CREATE TABLE [dbo].[Technicians] (
    [TechnicianId]               INT            IDENTITY (1, 1) NOT NULL,
    [DisplayName]                NVARCHAR (MAX) NOT NULL,
    [UserName]                   NVARCHAR (MAX) NOT NULL,
    [Password]                   NVARCHAR (MAX) NOT NULL,
    [CurrentLocation_LocationId] INT            NULL,
    [Skill_SkillId]              INT            NULL,
    CONSTRAINT [PK_dbo.Technicians] PRIMARY KEY CLUSTERED ([TechnicianId] ASC),
    CONSTRAINT [FK_dbo.Technicians_dbo.Locations_CurrentLocation_LocationId] FOREIGN KEY ([CurrentLocation_LocationId]) REFERENCES [dbo].[Locations] ([LocationId]),
    CONSTRAINT [FK_dbo.Technicians_dbo.Skills_Skill_SkillId] FOREIGN KEY ([Skill_SkillId]) REFERENCES [dbo].[Skills] ([SkillId])
);


GO
CREATE NONCLUSTERED INDEX [IX_CurrentLocation_LocationId]
    ON [dbo].[Technicians]([CurrentLocation_LocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Skill_SkillId]
    ON [dbo].[Technicians]([Skill_SkillId] ASC);
	
CREATE TABLE [dbo].[TechnicianSkills] (
    [Technician_TechnicianId] INT NOT NULL,
    [Skill_SkillId]           INT NOT NULL,
    CONSTRAINT [PK_dbo.TechnicianSkills] PRIMARY KEY CLUSTERED ([Technician_TechnicianId] ASC, [Skill_SkillId] ASC),
    CONSTRAINT [FK_dbo.TechnicianSkills_dbo.Technicians_Technician_TechnicianId] FOREIGN KEY ([Technician_TechnicianId]) REFERENCES [dbo].[Technicians] ([TechnicianId]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.TechnicianSkills_dbo.Skills_Skill_SkillId] FOREIGN KEY ([Skill_SkillId]) REFERENCES [dbo].[Skills] ([SkillId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_Technician_TechnicianId]
    ON [dbo].[TechnicianSkills]([Technician_TechnicianId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Skill_SkillId]
    ON [dbo].[TechnicianSkills]([Skill_SkillId] ASC);

CREATE TABLE [dbo].[Customers] (
    [CustomerId]                  INT            IDENTITY (1, 1) NOT NULL,
    [DisplayName]                 NVARCHAR (MAX) NULL,
    [CustomerLocation_LocationId] INT            NULL,
    CONSTRAINT [PK_dbo.Customers] PRIMARY KEY CLUSTERED ([CustomerId] ASC),
    CONSTRAINT [FK_dbo.Customers_dbo.Locations_CustomerLocation_LocationId] FOREIGN KEY ([CustomerLocation_LocationId]) REFERENCES [dbo].[Locations] ([LocationId])
);


GO
CREATE NONCLUSTERED INDEX [IX_CustomerLocation_LocationId]
    ON [dbo].[Customers]([CustomerLocation_LocationId] ASC);

CREATE TABLE [dbo].[WorkTasks] (
    [WorkTaskId]              INT      IDENTITY (1, 1) NOT NULL,
    [StartDateTime]           DATETIME NOT NULL,
    [EndDateTime]             DATETIME NOT NULL,
    [WorkStatus]              INT      NOT NULL,
    [Customer_CustomerId]     INT      NULL,
    [Technician_TechnicianId] INT      NULL,
    CONSTRAINT [PK_dbo.WorkTasks] PRIMARY KEY CLUSTERED ([WorkTaskId] ASC),
    CONSTRAINT [FK_dbo.WorkTasks_dbo.Customers_Customer_CustomerId] FOREIGN KEY ([Customer_CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId]),
    CONSTRAINT [FK_dbo.WorkTasks_dbo.Technicians_Technician_TechnicianId] FOREIGN KEY ([Technician_TechnicianId]) REFERENCES [dbo].[Technicians] ([TechnicianId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Customer_CustomerId]
    ON [dbo].[WorkTasks]([Customer_CustomerId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Technician_TechnicianId]
    ON [dbo].[WorkTasks]([Technician_TechnicianId] ASC);

GO
insert into dbo.Technicians (DisplayName, UserName, Password) values('Pranjal', 'pranjal', 'pranjal')
GO
