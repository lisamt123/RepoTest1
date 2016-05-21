/* Makes sure the printing doesn't overflow off the page */
	.gp_wrapper * {overflow-y: visible !important; float:none !important;}

/* Removes the background from Theme3 */
	body.sfdcBody {background:none repeat scroll 0 0 white;}

/* Removes the sidebar area from the bodyDiv */
	body .bodyDiv .outer td.oRightSidebarVisible{padding-left:0;}

/* Hides the Header */
	#AppBodyHeader {display: none; width: 0px; height: 0px;}

/* Hides the Sidebar */
	#sidebarDiv {display: none; width: 0px; height: 0px;}

/* Generic Style to hide things */
	.gp_hidewhenprinted {display: none; width: 0px; height: 0px;}

/* Page Setup information for printing a VF page */
@page {

	size:landscape; /* Landscape orientation */
	
	/* Put page numbers in the top right corner of each page in the pdf document. */
	@top-right
	{
		content: “Page ” counter(page);
	}
}