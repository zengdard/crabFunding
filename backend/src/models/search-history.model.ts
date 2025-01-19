import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';
import { v4 as uuidv4 } from 'uuid';
import User from './user.model';

interface SearchHistoryAttributes {
    id: string;
    userId: string;
    symbol: string;
    searchDate: Date;
}

interface SearchHistoryCreationAttributes extends Optional<SearchHistoryAttributes, 'id' | 'searchDate'> {}

class SearchHistory extends Model<SearchHistoryAttributes, SearchHistoryCreationAttributes> {
    public id!: string;
    public userId!: string;
    public symbol!: string;
    public searchDate!: Date;
}

SearchHistory.init(
    {
        id: {
            type: DataTypes.UUID,
            defaultValue: () => uuidv4(),
            primaryKey: true,
        },
        userId: {
            type: DataTypes.UUID,
            allowNull: false,
            references: {
                model: User,
                key: 'id',
            },
        },
        symbol: {
            type: DataTypes.STRING(20),
            allowNull: false,
        },
        searchDate: {
            type: DataTypes.DATE,
            defaultValue: DataTypes.NOW,
        },
    },
    {
        sequelize,
        modelName: 'SearchHistory',
        tableName: 'search_history',
        timestamps: false,
    }
);

export default SearchHistory; 