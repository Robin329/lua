
config = {

	url = "./config/mountconf.txt",       --要读取的配置文件路径 gemTest gemconfig mountconf guild.txt	
	tableName = "", --配置文件的表名(默认是txt的文件名;对表名搜索是忽略大小写的) MountConf GemConfig Guild lianyaohu
	logSave ="./log/", --日志保存路径
	as3Name = "",   --生成的主表AS3类名,默认是tableName加上Dp后缀	
	as3Save ="./as3/",  --生成的AS3保存路径
	as3Pkg = "com.data", --as3的包名
	readName = "readCFGData", --生成的GCReader的函数名
	GCRName = "GCReader", --生成的GCReader的文件名
	dataType = { --lua的数据类型对应AS3的数据类型
		table = "Array",
		number = "int",
		string = "String",
		sub = "",  --主表下的子结构体(非数组)对应AS3的类名,该串留空或者填* (如果留空串将会用生成的子结构体类代替)
	},
	filters ={ --过滤的字段名
		"touchEggExp",
		"touchEggXb",
		"totalTouch",
		"ssLevelLimit",
		"totalXianGuo",
		"xianGuoBackDay",
		"kickoutTimeLimit",
		"guildFubenSceneId",
		"impeachItem",
		"autoImpeachTime",
		"actorImpeachTime",
		"impeachTime",
		"autoImpeachOfflineTime",
		"xianGuoItemEx",
		"wealLimit",
		"titleConf",
	}, 

}
return config
