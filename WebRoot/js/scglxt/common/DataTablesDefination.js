(function(){
	window.DataTablesDefination = (function(){
		
		bLengthChange=false, 
     	oLanguage= {
                   "sProcessing": "正在加载中......",
                   "sLengthMenu": "每页显示 _MENU_ 条记录",
                   "sZeroRecords": "对不起，查询不到相关数据！",
                   "sEmptyTable": "表中无数据存在！",
                   "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                   "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                   "sSearch": "搜索",
                   "oPaginate": {
                       "sFirst": "首页",
                       "sPrevious": "上一页",
                       "sNext": "下一页",
                       "sLast": "末页"
                   }
       	},
        aLengthMenu=[15,30],
		scrollY= "380px",
		scrollX= true,
		scrollCollapse= false,
		paging = true,
		columnDefs= [ 
            {
                "render": function ( data, type, row ) {
                    return '<div ><a class="btn btn-success btn-xs " style="margin-left:10px;" href="${pageContext.request.contextPath}/scglxt/scgl/addSbInfo.jsp?flag=edit&id='+data+'"><i class="icon-ok"></i></a><a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/scglxt/scgl/scglsb_deleteSbInfo.action?id='+data+'"><i class="icon-remove"></i></a></div>';
                },
                "targets": 1
            },
            { "visible": true,  "targets": [ 2 ] }
        ]
	})();
})();