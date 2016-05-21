public class IdeasExtension {

    public IdeasExtension(ApexPages.StandardSetController controller) {
		
    }

	 private final ApexPages.IdeaStandardSetController ideaSetController;

    public IdeasExtension (ApexPages.IdeaStandardSetController controller) {
        this.ideaSetController = (Apexpages.Ideastandardsetcontroller) controller;        
    }

    public List<Idea> getIdeaList() {
        Idea[] ideas = ideaSetController.getIdeaList();
        // modify ideas here  
    	system.debug(ideas);
        return ideas;
    }
}