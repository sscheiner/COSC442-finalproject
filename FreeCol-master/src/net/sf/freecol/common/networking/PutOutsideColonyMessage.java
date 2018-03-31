/**
 *  Copyright (C) 2002-2015   The FreeCol Team
 *
 *  This file is part of FreeCol.
 *
 *  FreeCol is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  FreeCol is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with FreeCol.  If not, see <http://www.gnu.org/licenses/>.
 */

package net.sf.freecol.common.networking;

import net.sf.freecol.common.model.Game;
import net.sf.freecol.common.model.Player;
import net.sf.freecol.common.model.Unit;
import net.sf.freecol.server.FreeColServer;
import net.sf.freecol.server.model.ServerPlayer;

import org.w3c.dom.Element;


/**
 * The message sent when putting a unit outside a colony.
 */
public class PutOutsideColonyMessage extends DOMMessage {

    /** The identifier of the unit to be put out. */
    private final String unitId;


    /**
     * Create a new <code>PutOutsideColonyMessage</code> with the
     * supplied unit.
     *
     * @param unit The <code>Unit</code> to put outside.
     */
    public PutOutsideColonyMessage(Unit unit) {
        super(getXMLElementTagName());

        unitId = unit.getId();
    }

    /**
     * Create a new <code>PutOutsideColonyMessage</code> from a
     * supplied element.
     *
     * @param game The <code>Game</code> this message belongs to.
     * @param element The <code>Element</code> to use to create the message.
     */
    public PutOutsideColonyMessage(Game game, Element element) {
        super(getXMLElementTagName());

        unitId = element.getAttribute("unit");
    }


    /**
     * Handle a "putOutsideColony"-message.
     *
     * @param server The <code>FreeColServer</code> handling the message.
     * @param player The <code>Player</code> the message applies to.
     * @param connection The <code>Connection</code> message was received on.
     * @return An update encapsulating the change, or an error
     *     <code>Element</code> on failure.
     */
    public Element handle(FreeColServer server, Player player,
                          Connection connection) {
        final ServerPlayer serverPlayer = server.getPlayer(connection);

        Unit unit;
        try {
            unit = player.getOurFreeColGameObject(unitId, Unit.class);
        } catch (Exception e) {
            return DOMMessage.clientError(e.getMessage());
        }
        if (!unit.hasTile()) {
            return DOMMessage.clientError("Unit is not on the map: " + unitId);
        } else if (unit.getColony() == null) {
            return DOMMessage.clientError("Unit is not in a colony: "
                + unitId);
        }

        // Proceed to put outside.
        return server.getInGameController()
            .putOutsideColony(serverPlayer, unit);
    }

    /**
     * Convert this PutOutsideColonyMessage to XML.
     *
     * @return The XML representation of this message.
     */
    @Override
    public Element toXMLElement() {
        return createMessage(getXMLElementTagName(),
            "unit", unitId);
    }

    /**
     * The tag name of the root element representing this object.
     *
     * @return "putOutsideColony".
     */
    public static String getXMLElementTagName() {
        return "putOutsideColony";
    }
}
