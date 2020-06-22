-- DDL Scripts 

-- Crate Tables 

--- 1) Staging payent Details
CREATE TABLE [dbo].[stg_Payment_Hospital](
	[Facility_ID] [int] NOT NULL,
	[Facility_Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ZIP_Code] [nvarchar](50) NULL,
	[County_name] [nvarchar](50) NULL,
	[Phone_number] [nvarchar](50) NULL,
	[Payment_Measure_ID] [nvarchar](50) NULL,
	[Payment_Measure_Name] [nvarchar](50) NULL,
	[Payment_category] [nvarchar](50) NULL,
	[Denominator] [int] NULL,
	[Payment] [float] NULL,
	[Lower_estimate] [float] NULL,
	[Higher_estimate] [float] NULL,
	[Payment_footnote] [nvarchar](50) NULL,
	[Value_of_care_display_name] [nvarchar](50) NULL,
	[Value_of_care_display_ID] [nvarchar](50) NULL,
	[Value_of_care_category] [nvarchar](50) NULL,
	[Value_of_care_footnote] [nvarchar](50) NULL,
	[Start_Date] [smalldatetime] NULL,
	[End_Date] [smalldatetime] NULL,
	[Longitude] [nvarchar](50) NULL,
	[Latitude] [nvarchar](50) NULL
) ON [PRIMARY]
GO


-- 2) Staging inpatient 



CREATE TABLE [dbo].[stg_Inpatient_Payment_Details](
	[Drug_Code] [nvarchar](50) NULL,
	[Drug_Definition] [nvarchar](100) NOT NULL,
	[Provider_Id] [int] NOT NULL,
	[Provider_Name] [nvarchar](100) NULL,
	[Provider_Street_Address] [nvarchar](50) NULL,
	[Provider_City] [nvarchar](50) NULL,
	[Provider_State] [nvarchar](50) NULL,
	[Provider_Zip_Code] [int] NULL,
	[Hospital_Referral_Region__HRR__Description] [nvarchar](50) NULL,
	[Total_Discharges] [int] NULL,
	[Average_Covered_Charges] [float] NULL,
	[Average_Total_Payments] [float] NULL,
	[Average_Medicare_Payments] [float] NULL,
	[Year] [nvarchar](50) NULL
) ON [PRIMARY]
GO

-- 3) stg Outpatient 

CREATE TABLE [dbo].[stg_APC__Outpatient](
	[Provider_ID] [int] NOT NULL,
	[Provider_Name] [nvarchar](100) NOT NULL,
	[Provider_Street_Address] [nvarchar](50) NULL,
	[Provider_City] [nvarchar](50) NULL,
	[Provider_State] [nvarchar](50) NULL,
	[Provider_Zip_Code] [nvarchar](50) NULL,
	[Provider_HRR] [nvarchar](50) NULL,
	[APC] [nvarchar](50) NOT NULL,
	[APC_Description] [nvarchar](100) NULL,
	[Beneficiaries] [int] NULL,
	[Comprehensive_APC_Services] [int] NULL,
	[Average_Estimated_Total_Submitted_Charges] [float] NULL,
	[Average_Medicare_Allowed_Amount] [float] NULL,
	[Average_Medicare_Payment_Amount] [float] NULL,
	[Outlier_Comprehensive_APC_Services] [float] NULL,
	[Average_Medicare_Outlier_Amount] [float] NULL,
	[Year] [nvarchar](50) NULL
) ON [PRIMARY]
GO

-- 4) staging Outpatient HCPCS 


CREATE TABLE [dbo].[stg_APC_HCPCS_Outpatient](
	[State] [nvarchar](50) NOT NULL,
	[APC] [nvarchar](50) NOT NULL,
	[APC_Desc] [nvarchar](100) NULL,
	[HCPCS] [nvarchar](50) NULL,
	[HCPCS_Desc] [nvarchar](300) NULL,
	[Beneficiaries] [int] NULL,
	[CAPC_Services] [int] NULL,
	[Average_Total_Submitted_Charges] [float] NULL,
	[Average_Medicare_Allowed_Amount] [float] NULL,
	[Average_Medicare_Payment_Amount] [float] NULL,
	[Outlier_Services] [float] NULL,
	[Average_Medicare_Outlier_Amount] [float] NULL,
	[Year] [nvarchar](50) NULL
) ON [PRIMARY]
GO

-- Fact tables DDL 

-- 1) fact Outpatient details 


CREATE TABLE [dbo].[fact_outpatient_details](
	[Hospital_Key] [int] NOT NULL,
	[Apc_id_s] [int] NOT NULL,
	[Year_id] [int] NOT NULL,
	[Year] [nvarchar](50) NULL,
	[Beneficiaries] [int] NULL,
	[Comprehensive_APC_Services] [int] NULL,
	[Average_Estimated_Total_Submitted_Charges] [float] NULL,
	[Average_Medicare_Allowed_Amount] [float] NULL,
	[Average_Medicare_Payment_Amount] [float] NULL,
	[Outlier_Comprehensive_APC_Services] [float] NULL,
	[Average_Medicare_Outlier_Amount] [float] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_outpatient_details]  WITH CHECK ADD  CONSTRAINT [fk_apc_id_1] FOREIGN KEY([Apc_id_s])
REFERENCES [dbo].[dim_APC] ([Apc_id_s])
GO

ALTER TABLE [dbo].[fact_outpatient_details] CHECK CONSTRAINT [fk_apc_id_1]
GO

ALTER TABLE [dbo].[fact_outpatient_details]  WITH CHECK ADD  CONSTRAINT [fk_provider_id_2] FOREIGN KEY([Hospital_Key])
REFERENCES [dbo].[dim_hospital] ([Hospital_Key])
GO

ALTER TABLE [dbo].[fact_outpatient_details] CHECK CONSTRAINT [fk_provider_id_2]
GO

ALTER TABLE [dbo].[fact_outpatient_details]  WITH CHECK ADD  CONSTRAINT [fk_year_id_2] FOREIGN KEY([Year_id])
REFERENCES [dbo].[dim_year] ([Year_id])
GO

ALTER TABLE [dbo].[fact_outpatient_details] CHECK CONSTRAINT [fk_year_id_2]
GO


-- 2) fact HCPCS


CREATE TABLE [dbo].[fact_hosp_measures](
	[Hospital_Key] [int] NOT NULL,
	[Pay_meas_key] [int] NOT NULL,
	[Provider_ID] [int] NOT NULL,
	[Payment] [float] NULL,
	[Lower_estimate] [float] NULL,
	[Higher_estimate] [float] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_hosp_measures]  WITH CHECK ADD  CONSTRAINT [fk_pay_meas_id] FOREIGN KEY([Pay_meas_key])
REFERENCES [dbo].[dim_hosp_measures] ([Pay_meas_ID_s])
GO

ALTER TABLE [dbo].[fact_hosp_measures] CHECK CONSTRAINT [fk_pay_meas_id]
GO

ALTER TABLE [dbo].[fact_hosp_measures]  WITH CHECK ADD  CONSTRAINT [fk_provider_id] FOREIGN KEY([Hospital_Key])
REFERENCES [dbo].[dim_hospital] ([Hospital_Key])
GO

ALTER TABLE [dbo].[fact_hosp_measures] CHECK CONSTRAINT [fk_provider_id]
GO

-- 3) Fact hospital measures 


CREATE TABLE [dbo].[fact_hosp_measures](
	[Hospital_Key] [int] NOT NULL,
	[Pay_meas_key] [int] NOT NULL,
	[Provider_ID] [int] NOT NULL,
	[Payment] [float] NULL,
	[Lower_estimate] [float] NULL,
	[Higher_estimate] [float] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_hosp_measures]  WITH CHECK ADD  CONSTRAINT [fk_pay_meas_id] FOREIGN KEY([Pay_meas_key])
REFERENCES [dbo].[dim_hosp_measures] ([Pay_meas_ID_s])
GO

ALTER TABLE [dbo].[fact_hosp_measures] CHECK CONSTRAINT [fk_pay_meas_id]
GO

ALTER TABLE [dbo].[fact_hosp_measures]  WITH CHECK ADD  CONSTRAINT [fk_provider_id] FOREIGN KEY([Hospital_Key])
REFERENCES [dbo].[dim_hospital] ([Hospital_Key])
GO

ALTER TABLE [dbo].[fact_hosp_measures] CHECK CONSTRAINT [fk_provider_id]
GO


-- 4) Fact inpatient 



CREATE TABLE [dbo].[fact_inpatient_treatments](
	[Hospital_Key] [int] NOT NULL,
	[Inpatient_ID] [int] NOT NULL,
	[Year_id] [int] NOT NULL,
	[Year] [nvarchar](50) NULL,
	[Total_Discharges] [int] NULL,
	[Average_Covered_Charges] [float] NULL,
	[Average_Total_Payments] [float] NULL,
	[Average_Medicare_Payments] [float] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_inpatient_key_1] FOREIGN KEY([Inpatient_ID])
REFERENCES [dbo].[dim_inpatient_treatments ] ([Inpatient_ID])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_inpatient_key_1]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_provider_id_1] FOREIGN KEY([Hospital_Key])
REFERENCES [dbo].[dim_hospital] ([Hospital_Key])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_provider_id_1]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_year_id_1] FOREIGN KEY([Year_id])
REFERENCES [dbo].[dim_year] ([Year_id])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_year_id_1]
GO


--- Dimension tables DDL 

-- 1) dim APC


CREATE TABLE [dbo].[dim_APC](
	[Apc_id_s] [int] IDENTITY(1,1) NOT NULL,
	[APC] [nvarchar](50) NOT NULL,
	[APC_Desc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Apc_id_s] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 2) dim HCPCS


CREATE TABLE [dbo].[dim_HCPCS](
	[HCPCS_id_s] [int] IDENTITY(1,1) NOT NULL,
	[HCPCS] [nvarchar](50) NOT NULL,
	[HCPCS_Desc] [nvarchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[HCPCS_id_s] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 3) dim hosp_measures 



CREATE TABLE [dbo].[dim_hosp_measures](
	[Pay_meas_ID_s] [int] NOT NULL,
	[Payment_Measure_ID] [nvarchar](50) NULL,
	[Payment_Measure_Name] [nvarchar](50) NULL,
	[Payment_category] [nvarchar](50) NULL,
 CONSTRAINT [PK_dim_hosp_measures] PRIMARY KEY CLUSTERED 
(
	[Pay_meas_ID_s] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- 4) dim hospital 


CREATE TABLE [dbo].[dim_hospital](
	[Hospital_Key] [int] NOT NULL,
	[Provider_ID] [int] NOT NULL,
	[Provider_Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ZIP_Code] [nvarchar](50) NULL,
	[County_name] [nvarchar](50) NULL,
	[Phone_number] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[Latitude] [nvarchar](50) NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
 CONSTRAINT [PK_dim_hospital] PRIMARY KEY CLUSTERED 
(
	[Hospital_Key] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 5) dim inpatient treatment 



CREATE TABLE [dbo].[fact_inpatient_treatments](
	[Hospital_Key] [int] NOT NULL,
	[Inpatient_ID] [int] NOT NULL,
	[Year_id] [int] NOT NULL,
	[Year] [nvarchar](50) NULL,
	[Total_Discharges] [int] NULL,
	[Average_Covered_Charges] [float] NULL,
	[Average_Total_Payments] [float] NULL,
	[Average_Medicare_Payments] [float] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_inpatient_key_1] FOREIGN KEY([Inpatient_ID])
REFERENCES [dbo].[dim_inpatient_treatments ] ([Inpatient_ID])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_inpatient_key_1]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_provider_id_1] FOREIGN KEY([Hospital_Key])
REFERENCES [dbo].[dim_hospital] ([Hospital_Key])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_provider_id_1]
GO

ALTER TABLE [dbo].[fact_inpatient_treatments]  WITH CHECK ADD  CONSTRAINT [fk_year_id_1] FOREIGN KEY([Year_id])
REFERENCES [dbo].[dim_year] ([Year_id])
GO

ALTER TABLE [dbo].[fact_inpatient_treatments] CHECK CONSTRAINT [fk_year_id_1]
GO


--6)  dim year


CREATE TABLE [dbo].[dim_year](
	[Year_id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Year_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



















