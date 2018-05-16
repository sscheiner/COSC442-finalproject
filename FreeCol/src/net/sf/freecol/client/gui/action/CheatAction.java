package net.sf.freecol.client.gui.action;

import java.awt.event.ActionEvent;

import net.sf.freecol.client.FreeColClient;

public class CheatAction extends FreeColAction {

	public static final String id = "cheatAction";
	
    /**
     * Creates a new <code>CheatAction</code>.
     *
     * @param freeColClient The <code>FreeColClient</code> for the game.
     */
    public CheatAction(FreeColClient freeColClient) {
        super(freeColClient, id);
    }

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}

}
