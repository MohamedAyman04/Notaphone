CREATE VIEW allResolvedTickets AS
			SELECT *
			FROM Technical_Support_Ticket
			WHERE status = 'Resolved'
GO