class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (unauthenticated)
    
    if user.admin?
      can :manage, :all
      cannot :create, Complaint
      
    elsif user.staff?
      can :read, :staff_dashboard
      
      # Staff can manage tasks assigned to them
      can :read, Task, staff_id: user.id
      
      # Complaints and Comments
      can :read, Complaint
      can :create, Complaint
      can :create, Comment
      can :read, Comment

      can :read, Comment, complaint: { user_id: user.id }
      can :create, Comment, complaint: { user_id: user.id }
    elsif user.student?
      # Students access their own profiles and resources
      can :read, :profile
      
      # Students can read/create their own complaints
      can :read, Complaint, user_id: user.id
      can :create, Complaint
      
      # Students can read comments on their own complaints
      can :read, Comment, complaint: { user_id: user.id }
      can :create, Comment, complaint: { user_id: user.id }
      
      # Students can view available rooms
      can :read, Room
      # Students can view their active allocations
      can :read, Allocation, student_id: user.id
    end
  end
end