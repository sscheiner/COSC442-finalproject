/**
 * Copyright (C) 2002-2015   The FreeCol Team This file is part of FreeCol. FreeCol is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version. FreeCol is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with FreeCol.  If not, see <http://www.gnu.org/licenses/>.
 */
package net.sf.freecol.client;


import java.util.Comparator;
import net.sf.freecol.common.model.Colony;

/**
 * @see net.sf.freecol.client.ClientOptions#COLONY_COMPARATOR_POSITION
 */
public class ColonyComparatorPosition extends Type {
	public Comparator<Colony> getColonyComparator() {
		return ClientOptions.colonyPositionComparator;
	}
}